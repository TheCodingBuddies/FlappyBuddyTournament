from abc import abstractmethod, ABC


class BotAI(ABC):
    @abstractmethod
    def play(self, current_game_state):
        pass

    @abstractmethod
    def get_name(self):
        pass
