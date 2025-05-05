package bot

import "flappybuddy-bot/internal/model"

// Bot is the interface for all bot types.
// Any bot that implements this interface must define two methods:
// 1. Run: Determines the bot's behavior based on the current game state.
// 2. GetName: Returns the bot's name.
type Bot interface {
	// Run is the method that contains the logic for the bot's actions.
	// It takes the current game state as input and returns a boolean indicating
	// whether the bot should fly up or down.
	// The specific behavior of the bot (e.g. fly, avoid obstacles) depends on
	// the implementation of this method in the concrete bot.
	Run(state *model.PlayState) bool

	// GetName returns the name of the bot.
	// This name is used for two purposes:
	// 1. To create the websocket URL for communication with the game server.
	// 2. To display the bot's name within the game.
	// Each bot will have its own unique name (e.g. "AggressiveBot").
	// This allows the game to know which bot is being used and show the correct name.
	GetName() string
}
