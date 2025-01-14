package cb;

import cb.bots.AiFactory;
import cb.bots.BotAi;

import java.net.URI;
import java.net.URISyntaxException;

public class Main {
    private static BotAi getBot(String[] args) {
        if (args.length > 0) {
            return AiFactory.create(args[0]);
        } else {
            return AiFactory.create("MyAI");
        }
    }

    private static int getPort(String[] args) {
        if (args.length > 1) {
            return Integer.parseInt(args[1]);
        } else {
            return 5050;
        }
    }

    public static void main(String[] args) throws URISyntaxException, InterruptedException {
        BotAi bot = getBot(args);
        int port = getPort(args);
        String serverUri = "ws://localhost:" + port + "/" + bot.getName();
        CustomWebsocketClient client = new CustomWebsocketClient(new URI(serverUri), bot);

        client.connectBlocking();
    }
}