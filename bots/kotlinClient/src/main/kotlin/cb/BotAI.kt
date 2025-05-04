package cb


interface BotAI<R, S>
{

    val name: String

    /**
     * @param gamePacket current packet
     */
    fun play(gamePacket: R): S

}