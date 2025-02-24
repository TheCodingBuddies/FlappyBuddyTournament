from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import List


@dataclass
class Player:
    height: int
    width: int
    pos_x: float
    pos_y: float
    rotation: float
    state: str

    @staticmethod
    def from_dict(data) -> Player:
        return Player(data['height'], data['width'], data['pos_x'], data['pos_y'], data['rotation'], data['state'])


@dataclass
class Obstacle:
    type: str
    origin_x: float
    origin_y: float
    height: int
    width: int
    close_area_height: int
    close_area_width: int

    @staticmethod
    def from_dict(data) -> Obstacle:
        return Obstacle(data["type"], data["origin_x"], data["origin_y"], data["height"], data["width"], data["close_area_height"], data['close_area_width'])


class FromServerPacket(ABC):
    @staticmethod
    @abstractmethod
    def from_dict(data: dict) -> FromServerPacket:
        pass


@dataclass
class PlayState(FromServerPacket):
    level_time: float
    score: float
    player: Player
    obstacles: List[Obstacle]

    @staticmethod
    def from_dict(data: dict) -> PlayState:
        obstacles = [Obstacle.from_dict(entry) for entry in data['obstacles']]
        return PlayState(data["level_time"], data['score'], Player.from_dict(data["player"]), obstacles)
