package cb.flappybuddy

import cb.WebsocketClient
import cb.flappybuddy.bots.FlappyBuddyAIFactory
import cb.flappybuddy.game.GameData
import cb.flappybuddy.game.Response
import kotlinx.cli.ArgParser
import kotlinx.cli.ArgType
import kotlinx.cli.default
import kotlinx.cli.optional

object FlappyBuddyMain
{
    fun start(botName: String = "MyAI", port: Int = 5050)
    {
        val ai = FlappyBuddyAIFactory.create(botName)
        WebsocketClient().connect<GameData, Response>(ai = ai, port = port, path = ai.name)
    }
}

fun main(args: Array<String>)
{
    val parser = ArgParser("CodingBuddies-kotlin-bots")
    val botName by parser.argument(ArgType.String, description = "Bot's Name").optional().default("MyAI")
    val portNumber by parser.argument(ArgType.Int, description = "Port's Number").optional().default(5050)
    println(parser.parse(args))
    FlappyBuddyMain.start(botName, portNumber)
}