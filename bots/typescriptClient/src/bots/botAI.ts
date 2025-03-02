import { PlayState } from './data';

export interface BotAI {
  play(currentGameState: PlayState): boolean;
  getName(): string;
} 