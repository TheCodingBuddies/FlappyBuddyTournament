from Bots.bot_ai import BotAI
from Bots.data import PlayState


class MyAI(BotAI):
    fly = True

    def play(self, current_game_state: PlayState):
        print(self.fly)
        # todo: put your logic code here
        return self.fly

    def get_name(self):
        return self.name

    def __init__(self):
        # todo: give your bot a super duper cool name
        self.name = "YourBotName"
