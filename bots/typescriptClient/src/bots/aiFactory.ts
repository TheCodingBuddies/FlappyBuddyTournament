import { BotAI } from './botAI';
import { FirstAI } from './firstAI';
import { MyAI } from './myAI';

const aiBots: Record<string, new () => BotAI> = {
  'FirstAI': FirstAI,
  'MyAI': MyAI,
};

export function aiFactory(botSelection: string = 'MyAI'): BotAI {
  const BotClass = aiBots[botSelection];
  if (!BotClass) {
    throw new Error(`Bot type '${botSelection}' not found`);
  }
  return new BotClass();
} 