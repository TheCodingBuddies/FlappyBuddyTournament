package cb.flappybuddy.bots

import cb.WebsocketClient
import cb.flappybuddy.game.GameData
import cb.flappybuddy.game.Response

class MyAI : FlappyBuddyAI
{
    override val name: String = "MyAI"

    override fun play(gamePacket: GameData): Response
    {
        //Add your custom code here
        return Response(false)
    }
}

fun main()
{
    val ai = MyAI()
    WebsocketClient().connect<GameData, Response>(ai = ai, path = ai.name)
}