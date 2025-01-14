from Bots.bot_ai import BotAI
from Bots.first_ai import FirstAI
from Bots.my_ai import MyAI

ai_bots = {
    "FirstAI": FirstAI,
    "MyAI": MyAI,
}


def ai_factory(bot_selection="MyAI") -> BotAI:
    return ai_bots[bot_selection]()
