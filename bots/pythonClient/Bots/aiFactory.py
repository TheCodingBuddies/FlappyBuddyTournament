from Bots.bot_ai import BotAI
from Bots.first_ai import FirstAI

ai_bots = {
    "FirstAI": FirstAI
}


def ai_factory(bot_selection="FirstAI") -> BotAI:
    return ai_bots[bot_selection]()
