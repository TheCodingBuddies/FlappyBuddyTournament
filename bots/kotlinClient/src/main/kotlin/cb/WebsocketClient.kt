package cb

import io.ktor.client.HttpClient
import io.ktor.client.plugins.websocket.WebSockets
import io.ktor.client.plugins.websocket.webSocket
import io.ktor.serialization.kotlinx.KotlinxWebsocketSerializationConverter
import io.ktor.websocket.*
import kotlinx.coroutines.channels.onClosed
import kotlinx.coroutines.runBlocking
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.Json
import kotlin.time.measureTime

class WebsocketClient()
{
    val json = Json {
        ignoreUnknownKeys = true
        encodeDefaults = true
    }

    val client = HttpClient {
        install(WebSockets) {
            contentConverter = KotlinxWebsocketSerializationConverter(json)
        }
    }

    inline fun <reified R, reified S> connect(ai: BotAI<R, S>, host: String = "localhost", port: Int = 5050, path: String = "")
    {
        runBlocking {
            client.webSocket(
                host = host,
                port = port,
                path = path
            ) {
                println("Connected to Websocket")
                var running = true
                while (running)
                {
                    try
                    {
                        val frame = incoming.receiveCatching().onClosed {
                            println("Websocket closed")
                            running = false
                        }.getOrNull()
                        if (frame == null)
                        {
                            break
                        }
                        var text: String? = null
                        val textDecodeTime = measureTime {
                            when (frame.frameType)
                            {
                                FrameType.TEXT   ->
                                {
                                    text = (frame as Frame.Text).readText()
                                    println("Got Text $text")
                                }

                                FrameType.BINARY ->
                                {
                                    text = (frame as Frame.Binary).readBytes().decodeToString()
                                    println("Got Binary $text")
                                }

                                FrameType.CLOSE  -> println("Got Close ${(frame as Frame.Close).readReason()}")
                                FrameType.PING   -> println("Got PING")
                                FrameType.PONG   -> println("Got PONG")
                            }
                        }
                        println("Took $textDecodeTime to decode to text")
                        if (text == null || text.isEmpty())
                        {
                            continue
                        }
                        val responseTime = measureTime {
                            val response = ai.play(json.decodeFromString<R>(text))
                            send(json.encodeToString<S>(response))
                        }
                        println("Responded in $responseTime")
                    } catch (e: Exception)
                    {
                        if (e is SerializationException || e is IllegalStateException)
                        {
                            println("Got SerializationException\n${e.message}\nInterpreting as PING")
                        } else
                        {
                            e.printStackTrace()
                        }
                    }

                }
            }
        }
    }
}