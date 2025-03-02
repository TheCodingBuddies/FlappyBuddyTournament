# Flappy Buddy Tournament - TypeScript Client

Dies ist eine TypeScript-Implementierung des Clients für das Flappy Buddy Tournament Spiel.

## Voraussetzungen

- Node.js (v14 oder höher)
- npm oder yarn

## Einrichtung

1. Abhängigkeiten installieren:
   ```bash
   npm install
   # oder
   yarn install
   ```

2. TypeScript-Code kompilieren:
   ```bash
   npm run build
   # oder
   yarn build
   ```

## Client ausführen

Du kannst den Client mit Standardeinstellungen ausführen (MyAI-Bot auf Port 5050):

```bash
npm start
# oder
yarn start
```

Um einen anderen Bot oder Port anzugeben:

```bash
# Format: npm start -- <botName> <port>
npm start -- FirstAI 5050
# oder
yarn start -- FirstAI 5050
```

Für die Entwicklung mit automatischem Neuladen:

```bash
npm run dev
# oder
yarn dev
```

## Deinen eigenen Bot erstellen

1. Erstelle eine neue Datei im Verzeichnis `src/bots` (z.B. `myCustomBot.ts`)
2. Implementiere die `BotAI`-Schnittstelle
3. Füge deinen Bot zum `aiBots`-Objekt in `src/bots/aiFactory.ts` hinzu
4. Führe den Client mit dem Namen deines Bots als erstes Argument aus

Beispiel:

```typescript
// src/bots/myCustomBot.ts
import { BotAI } from './botAI';
import { PlayState } from './data';

export class MyCustomBot implements BotAI {
  private name: string = 'MyAwesomeBot';
  private fly: boolean = true;

  play(currentGameState: PlayState): boolean {
    // Deine benutzerdefinierte Logik hier
    return this.fly;
  }

  getName(): string {
    return this.name;
  }
}
```

Dann füge ihn zur Factory hinzu:

```typescript
// In src/bots/aiFactory.ts
import { MyCustomBot } from './myCustomBot';

const aiBots: Record<string, new () => BotAI> = {
  'FirstAI': FirstAI,
  'MyAI': MyAI,
  'MyCustomBot': MyCustomBot,
};
```

## Projektstruktur

- `src/index.ts` - Haupteinstiegspunkt, der die WebSocket-Kommunikation verwaltet
- `src/bots/` - Verzeichnis mit Bot-Implementierungen
  - `botAI.ts` - Schnittstelle, die alle Bots implementieren müssen
  - `data.ts` - Typdefinitionen für den Spielzustand
  - `aiFactory.ts` - Factory zum Erstellen von Bot-Instanzen
  - `firstAI.ts` - Beispiel-Bot-Implementierung
  - `myAI.ts` - Vorlage für deinen benutzerdefinierten Bot 