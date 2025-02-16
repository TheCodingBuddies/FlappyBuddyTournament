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

    @staticmethod
    def from_dict(data) -> Player:
        return Player(data['height'], data['width'], data['pos_x'], data['pos_y'], data['rotation'])


@dataclass
class Obstacle:
    type: str
    origin_x: float
    origin_y: float
    height: int
    width: int

    @staticmethod
    def from_dict(data) -> Obstacle:
        return Obstacle(data["type"], data["origin_x"], data["origin_y"], data["height"], data["width"])


class FromServerPacket(ABC):
    @staticmethod
    @abstractmethod
    def from_dict(data: dict) -> FromServerPacket:
        pass


@dataclass
class PlayState(FromServerPacket):
    level_time: float
    player: Player
    obstacles: List[Obstacle]

    @staticmethod
    def from_dict(data: dict) -> PlayState:
        ref_ticks = data["level_time"]
        obstacles = [Obstacle.from_dict(entry) for entry in data['obstacles']]
        return PlayState(ref_ticks, Player.from_dict(data["player"]), obstacles)
