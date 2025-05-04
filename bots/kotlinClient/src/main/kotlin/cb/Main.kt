package cb

import cb.flappybuddy.FlappyBuddyMain
import kotlinx.cli.ArgParser
import kotlinx.cli.ArgType
import kotlinx.cli.optional

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
fun main(args: Array<String>)
{
    val parser = ArgParser("CodingBuddies-kotlin-bots")
    val tournament by parser.argument<Tournaments>(ArgType.Choice(), description = "Tournament Name")
    val botName by parser.argument(ArgType.String, description = "Bot's Name").optional()
    val portNumber by parser.argument(ArgType.Int, description = "Port's Number").optional()
    println(parser.parse(args))
    when (tournament)
    {
        Tournaments.FLAPPY_BUDDY ->
        {
            FlappyBuddyMain.start(botName!!, portNumber!!)
        }
    }
}