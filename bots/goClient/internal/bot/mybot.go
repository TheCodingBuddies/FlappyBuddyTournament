package bot

import "flappybuddy-bot/internal/model"

// MyBot implements the Bot interface for an aggressive bot.
type MyBot struct {
	// flyState determines whether the bot is flying up or down.
	// If true, the bot will fly up and if false the bot will fly down.
	flyState bool
}

// Run processes the current game state and determines whether the bot should fly up or down.
// In this implementation, the bot simply does nothing.
func (b *MyBot) Run(state *model.PlayState) bool {
	// Return the current flying state (true = fly up, false = fly down)
	return b.flyState
}

// flyUp sets the flyState of the bot to true,
// indicating that the bot is now flying up.
func (b *MyBot) flyUp() {
	b.flyState = true
}

// flyDown sets the flyState of the bot to false,
// indicating that the bot is now flying down.
func (b *MyBot) flyDown() {
	b.flyState = false
}

// GetName returns the name of the bot. This name is used for creating the WebSocket URL
// and displaying the bot's name within the game.
func (b *MyBot) GetName() string {
	return "MyBot"
}
