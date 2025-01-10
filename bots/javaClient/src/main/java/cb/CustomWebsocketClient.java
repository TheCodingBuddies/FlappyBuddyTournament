package cb;

import cb.bots.BotAi;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.java_websocket.client.WebSocketClient;
import org.java_websocket.handshake.ServerHandshake;

import java.net.URI;
import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.Map;

public class CustomWebsocketClient extends WebSocketClient {
    private final ObjectMapper mapper = new ObjectMapper();
    private final BotAi bot;

    public CustomWebsocketClient(URI serverUri, BotAi ai) {
        super(serverUri);
        bot = ai;
    }

    @Override
    public void onOpen(ServerHandshake handshakedata) {
        System.out.println("Connection to Flappy Buddy Game opened");
    }

    @Override
    public void onMessage(String s) {
        System.out.println("on message string");
    }

    @Override
    public void onMessage(ByteBuffer bytes) {
        System.out.println("on message bytes");
        try {
            String decodedMessage = new String(bytes.array(), StandardCharsets.UTF_8)
                    .replace("'", "\"");
            System.out.println(decodedMessage);
            PlayState response = mapper.readValue(decodedMessage, PlayState.class);
            Map<String, Object> responseMap = Map.of("fly", bot.play(response));
            String jsonResponse = mapper.writeValueAsString(responseMap);
            send(jsonResponse);
        } catch (Exception e) {
            if (e instanceof java.nio.charset.CharacterCodingException) {
                System.out.println("Got ping message");
            } else if (e instanceof JsonParseException) {
                System.out.println("Got ping message");
            } else {
                e.printStackTrace();
            }
        }
    }


    @Override
    public void onClose(int code, String reason, boolean remote) {
        System.out.println("Verbindung zum Server geschlossen: " + reason);
    }

    @Override
    public void onError(Exception ex) {
        System.err.println("Fehler: " + ex.getMessage());
    }
}