import asyncio
import json
import sys

import websockets

from Bots.aiFactory import ai_factory
from Bots.data import PlayState


async def handle_message(bot, websocket):
    response_as_string = await websocket.recv()
    try:
        decoded_response = response_as_string.decode('utf-8').replace("'", '"')
        response: PlayState = PlayState.from_dict(json.loads(decoded_response))
        bot_answer = bot.play(response)
        await websocket.send(json.dumps({"fly": bot_answer}))
    except UnicodeDecodeError:
        print("got ping message")


async def client(bot, port):
    uri = f"ws://localhost:{port}/{bot.get_name()}"
    async with websockets.connect(uri, ping_timeout=None, ping_interval=None) as websocket:
        print("Connected to server.")
        while True:
            try:
                await handle_message(bot, websocket)
            except websockets.ConnectionClosedOK:
                print("Connection closed by server.")
                break
            except websockets.ConnectionClosedError:
                print("Server was shut down.")
                break


if __name__ == "__main__":
    ai_bot = ai_factory()
    used_port = 5050
    if len(sys.argv) == 2:
        ai_bot = ai_factory(sys.argv[1])
    if len(sys.argv) == 3:
        ai_bot = ai_factory(sys.argv[1])
        used_port = sys.argv[2]

    asyncio.run(client(ai_bot, used_port))
