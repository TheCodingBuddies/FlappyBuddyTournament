from Bots.bot_ai import BotAI
from Bots.first_ai import FirstAI
from Bots.bodennuckel import BodenNuckel

ai_bots = {
    "FirstAI": FirstAI,
    "BodenNuckel": BodenNuckel,
}


def ai_factory(bot_selection="MyAI") -> BotAI:
    return ai_bots[bot_selection]()
