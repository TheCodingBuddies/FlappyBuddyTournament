import { BotAI } from './botAI';
import { PlayState } from './data';

export class FirstAI implements BotAI {
  private name: string = 'TypeScriptTestBot';
  private fly: boolean = true;

  play(currentGameState: PlayState): boolean {
    console.log(currentGameState);
    if (currentGameState.player.pos_y > 450) {
      this.fly = true;
    }

    if (currentGameState.player.pos_y < 50) {
      this.fly = false;
    }

    return this.fly;
  }

  getName(): string {
    return this.name;
  }
} 