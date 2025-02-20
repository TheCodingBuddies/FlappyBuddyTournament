# Willkommen zum KI Wettbewerb "Flappy Buddy" von den Coding Buddies!

Ab dem 24.02.2025 findet unser nächster Programmierwettbewerb statt. 

**Grundsätzlich gilt:**

Solltet ihr Fragen haben oder Hilfe benötigen. Scheut euch nicht uns auf unseren Plattformen zu kontaktieren!

**UND ACHTUNG! Der Spaß und das Lernen steht im Vordergrund also macht mit :)** <br>

## Aufgabe

Es ist ein **Bot** zu entwickeln, der die Kontrolle des Fliegers in Flappy Buddy übernimmt. Hierfür haben wir eine
Schnittstelle in den jeweiligen Clients (Java, Python, C# oder Rust) bereit gestellt, welche implementiert werden muss. 
Das Ziel ist es die Ziellinie zu erreichen und dabei so viele Münzen wie möglich einzusammeln. Knacke den Highscore!

## Teilnahmebedingungen

- Implementierung der vorgegebenen Bot Schnittstelle (in der Sprache deiner Wahl)
- Der Bot ist lauffähig und sendet valide Antworten an den Spieleserver
- Die KI ist selbst geschrieben

## Anforderungen

- Python 3.10.4+ (falls der Bot in Python geschrieben wird)
- Java SDK 17+  (falls der Bot in Java geschrieben wird)
- dotnet 8.0 (falls der Bot in csharp geschrieben wird)
- rust 1.84 (falls der Bot in Rust geschrieben wird)

### Was beinhaltet das Repository?

- Das Flappy Buddy Spiel + Source Code Godot
- Die Bot Clients in den jeweiligen Sprachen:
  - Python
  - Java
  - C##
  - Rust

## Einen Client mit dem Server verbinden (Python)

Den Python Client starten:

```  
cd pythonClient
py bot.py <BotName> <Port>
``` 

| Parameter | Beschreibung                                           |
|-----------|--------------------------------------------------------|
| BotName   | Name der KI, die gestartet werden soll (default: MyAI) |
| Port      | Port des Servers (default: 5050)                       |

Möchtest du beispielsweise die KI FirstAI starten und der Server läuft auf 8765:

```  
py bot FirstAI 8765
```

## Einen Client mit dem Server verbinden (Java)

Den Java Client starten:

```  
cd javaClient   # in den javaClient Ordner wechseln
.\gradlew run   # startet den JavaCleint mit den Standard Settings
```

Um einen anderen Port oder eine andere KI zu verwenden:

```  
.\gradlew run --args="<BotName> <Port>"
``` 

| Parameter | Beschreibung                                           |
|-----------|--------------------------------------------------------|
| BotName   | Name der KI, die gestartet werden soll (default: MyAI) |
| Port      | Port des Servers (default: 5050)                       |

Möchtest du beispielsweise deine eigene KI MyBot starten und der Server läuft auf 5555:

```  
.\gradlew run --args="MyBot 5555"
``` 

## Einen Client mit dem Server verbinden (C#)

Den C# Client starten <br>
(mit den Settings aus csharpClient\Client\Properties\launch.json)

```
cd csharpClient\Client
dotnet run
```
| Parmeter | Switch         | Beschreibung                                  | Default     |
| -------- | -------------- | --------------------------------------------- | ----------- |
BotName    | -n or --name   | Name der KI, die gestartet werden soll        | UserBot     |
Server     | -s or --server | Serveradresse (ip oder dns)                   | localhost   |
Port       | -p or --port   | Port des 4 Connect Servers auf dem Zielserver | 8765        |

Wenn ihr also mehrere Bots geschrieben habt, könnt ihr mit dem Namen das ganze umschalten.
Es ist aber natürlich auch ausreichend den Default zu belassen und alles im "MyAi" zu machen.

#### more information soon 😄

