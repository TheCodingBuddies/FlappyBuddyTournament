from Bots.bot_ai import BotAI
from Bots.data import PlayState


class FirstAI(BotAI):
    fly = True

    def play(self, current_game_state: PlayState):
        if current_game_state.player.pos_y > 450:
            self.fly = True

        if current_game_state.player.pos_y < 50:
            self.fly = False

        return self.fly

    def get_name(self):
        return self.name

    def __init__(self):
        self.name = "PythonTestBot"
        self.token_id = None
