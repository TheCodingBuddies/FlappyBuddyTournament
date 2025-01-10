import asyncio
import json
import sys

import websockets

from Bots.aiFactory import ai_factory
from Bots.data import PlayState


async def client(ai_bot, port):

    uri = f"ws://localhost:{port}/{ai_bot.get_name()}"
    async with websockets.connect(uri, ping_timeout=None, ping_interval=None) as websocket:
        while True:
            response_as_string = await websocket.recv()
            try:
                decoded_response = response_as_string.decode('utf-8').replace("'", '"')
                response: PlayState = PlayState.from_dict(json.loads(decoded_response))
                bot_answer = ai_bot.play(response)
                await websocket.send(json.dumps({"fly": bot_answer}))
            except UnicodeDecodeError:
                print("got ping message")


if __name__ == "__main__":
    ai_bot = ai_factory()
    port = 5050
    if len(sys.argv) == 2:
        ai_bot = ai_factory(sys.argv[1])
    if len(sys.argv) == 3:
        ai_bot = ai_factory(sys.argv[1])
        port = sys.argv[2]

    asyncio.get_event_loop().run_until_complete(client(ai_bot, port))
