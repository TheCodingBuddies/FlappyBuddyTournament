import WebSocket from "ws";
import { aiFactory } from "./bots/aiFactory";
import { BotAI } from "./bots/botAI";
import { PlayState } from "./bots/data";

async function handleMessage(bot: BotAI, websocket: WebSocket): Promise<void> {
  return new Promise((resolve, reject) => {
    websocket.once("message", (data: WebSocket.Data) => {
      try {
        let responseAsString: string;

        // Handle binary data
        if (data instanceof Buffer) {
          try {
            responseAsString = data.toString("utf8");

            // Try to parse as JSON to see if it's a valid game state
            const jsonData = JSON.parse(responseAsString);

            // Check if it has the expected PlayState structure
            if (
              jsonData &&
              typeof jsonData === "object" &&
              "player" in jsonData &&
              "obstacles" in jsonData
            ) {
              console.log("Received binary game state data");
            } else {
              console.log("Received binary data but not a valid PlayState");
              resolve();
              return;
            }
          } catch (error) {
            // If parsing fails, it's likely a ping or other binary message
            console.log("Got ping message or unparseable binary data");
            resolve();
            return;
          }
        } else {
          responseAsString = data.toString();
        }

        const response: PlayState = JSON.parse(responseAsString);
        const botAnswer = bot.play(response);
        websocket.send(JSON.stringify({ fly: botAnswer }));
        resolve();
      } catch (error) {
        console.error("Error handling message:", error);
        reject(error);
      }
    });
  });
}

async function client(bot: BotAI, port: number): Promise<void> {
  const uri = `ws://localhost:${port}/${bot.getName()}`;

  const websocket = new WebSocket(uri, {
    perMessageDeflate: false,
  });

  return new Promise((resolve, reject) => {
    websocket.on("open", async () => {
      console.log("Connected to server.");

      try {
        while (websocket.readyState === WebSocket.OPEN) {
          await handleMessage(bot, websocket);
        }
      } catch (error) {
        console.error("Connection error:", error);
      }
    });

    websocket.on("close", (code, reason) => {
      console.log(
        `Connection closed by server. Code: ${code}, Reason: ${reason}`
      );
      resolve();
    });

    websocket.on("error", (error) => {
      console.error("Server was shut down or connection error:", error);
      reject(error);
    });
  });
}

// Main execution
async function main() {
  try {
    const args = process.argv.slice(2);
    let botSelection;
    let port = 5050;

    if (args.length >= 1) {
      botSelection = args[0];
    }

    if (args.length >= 2) {
      port = parseInt(args[1], 10);
    }

    const aiBot = aiFactory(botSelection);
    await client(aiBot, port);
  } catch (error) {
    console.error("Error in main:", error);
    process.exit(1);
  }
}

// Run the main function
main().catch((error) => {
  console.error("Unhandled error:", error);
  process.exit(1);
});
