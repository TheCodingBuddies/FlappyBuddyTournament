package cb.flappybuddy.bots

import cb.WebsocketClient
import cb.flappybuddy.game.GameData
import cb.flappybuddy.game.Response
import kotlin.random.Random

class RandomBot : FlappyBuddyAI
{
    override val name: String = "RandomBot"

    override fun play(gamePacket: GameData): Response
    {
        println(gamePacket)
        return Response(Random.Default.nextBoolean())
    }
}

fun main()
{
    val ai = RandomBot()
    WebsocketClient().connect<GameData, Response>(ai = ai, path = ai.name)
}