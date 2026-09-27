using CommandLine;
using CsClient.Bots.Internal;
using CsClient.CsharpClient;

var result = Parser.Default.ParseArguments<Options>(args);

if (result.Tag == ParserResultType.NotParsed)
{
    OnError(result.Errors);
    return -1;
}

await RunAsync(result.Value).ConfigureAwait(false);
return 0;

static async Task RunAsync(Options o)
{
#if DEBUG
    Console.WriteLine("Debug Mode");
#endif

    string serverUrl = $"ws://{o.Server}:{o.Port}";
    Console.WriteLine($"Run Bot {o.Name} with Serveraddress: {serverUrl}");

    var myClient = new FlappyBuddyWebsocketClient(
        BotFactory.GetBotByName(o.Name!));

    myClient.OnOpen += (_, _) => { Console.WriteLine("Connected!"); };
    myClient.OnClose += async (_, _) =>
    {
        await myClient.DisconnectAsync().ConfigureAwait(false);
        Console.WriteLine("Closed");
    };

    await myClient.Connect(serverUrl).ConfigureAwait(false);
}

static void OnError(IEnumerable<Error> errors)
{
    Console.WriteLine(string.Join(Environment.NewLine, errors));
}

public class Options
{
    [Option('n', "name", Default = "MyAi", HelpText = "Name for your bot")]
    public string? Name { get; set; }

    [Option('s', "server", Default = "localhost", HelpText = "Server with running Flappy Buddy Service")]
    public string? Server { get; set; }

    [Option('p', "port", Default = 5050, HelpText = "Used Port for server connection")]
    public int Port { get; set; }
}