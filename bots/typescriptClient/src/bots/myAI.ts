import { BotAI } from './botAI';
import { PlayState } from './data';

export class MyAI implements BotAI {
  private name: string = 'YourBotName';
  private fly: boolean = true;

  play(currentGameState: PlayState): boolean {
    // todo: put your logic code here
    return this.fly;
  }

  getName(): string {
    return this.name;
  }
} 