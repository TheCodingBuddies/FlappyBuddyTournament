package cb.flappybuddy.bots

object FlappyBuddyAIFactory
{
    fun create(name: String): FlappyBuddyAI
    {
        return when (name)
        {
            "RandomBot" -> RandomBot()
            //Add your custom code to MyAI, or reference a new class here
            else        -> MyAI()
        }
    }

}