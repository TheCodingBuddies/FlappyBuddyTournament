package bot

import "errors"

// BotFactory provides a function to create various types of bots
// This factory pattern allows for easy addition of new bot types in the future.
type BotFactory struct{}

// NewBot creates a new bot based on the given name.
// It returns a specific bot implementation or an error if the bot type is unknown.
func (f *BotFactory) NewBot(name string) (Bot, error) {
	// Use a switch statement to decide which type of bot to create based on the provided name
	switch name {
	case "FirstBot":
		// Create and return the example bot
		return &FirstBot{flyState: false}, nil
	case "MyBot":
		// Create and return the bot template bot
		return &MyBot{flyState: false}, nil
	default:
		// Return an error if the bot name is unknown
		return nil, errors.New("unknown bot type: " + name)
	}
}
