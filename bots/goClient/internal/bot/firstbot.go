package bot

import "flappybuddy-bot/internal/model"

// FirstBot implements the Bot interface for an example bot.
// The bot makes decisions based on the player's Y position and adjusts its flying state.
type FirstBot struct {
	// flyState determines whether the bot is flying up or down.
	// If true, the bot will fly up and if false the bot will fly down.
	flyState bool
}

// Run processes the current game state and determines whether the bot should fly up or down.
// In this implementation, the bot simply reacts to the Y position of the player:
// - If the player is too far down (Y > 450), the bot will make the player fly up.
// - If the player is too high (Y < 50), the bot will stop flying and let the player fly down.
func (b *FirstBot) Run(state *model.PlayState) bool {
	// If the player's Y position is above 450, let the player fly up
	if state.Player.PosY > 450.0 {
		b.flyUp()
	} else if state.Player.PosY < 50.0 { // If the player's Y position is below 50, let the player fly down
		b.flyDown()
	}

	// Return the current flying state (true = fly up, false = fly down)
	return b.flyState
}

// flyUp sets the flyState of the bot to true,
// indicating that the bot is now flying up.
func (b *FirstBot) flyUp() {
	b.flyState = true
}

// flyDown sets the flyState of the bot to false,
// indicating that the bot is now flying down.
func (b *FirstBot) flyDown() {
	b.flyState = false
}

// GetName returns the name of the bot. This name is used for creating the WebSocket URL
// and displaying the bot's name within the game.
func (b *FirstBot) GetName() string {
	return "FirstBot"
}
