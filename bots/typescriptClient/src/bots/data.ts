export interface Player {
  height: number;
  width: number;
  pos_x: number;
  pos_y: number;
  rotation: number;
  state: string;
}

export interface Obstacle {
  type: string;
  origin_x: number;
  origin_y: number;
  height: number;
  width: number;
  close_area_height: number;
  close_area_width: number;
}

export interface PlayState {
  level_time: number;
  score: number;
  player: Player;
  obstacles: Obstacle[];
} 