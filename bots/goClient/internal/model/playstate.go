package model

// Player represents the player's attributes within the game.
type Player struct {
	Height   float64 `json:"height"`   // Height of the player
	Width    float64 `json:"width"`    // Width of the player
	PosX     float64 `json:"pos_x"`    // X-coordinate position of the player
	PosY     float64 `json:"pos_y"`    // Y-coordinate position of the player
	Rotation float64 `json:"rotation"` // Rotation angle of the player
	State    string  `json:"state"`    // Current state of the player (e.g. "alive", "died")
}

// Obstacle represents a game obstacle such as a bird.
type Obstacle struct {
	Type            string  `json:"type"`              // Type of the obstacle (e.g. "Raven", "Coin")
	OriginX         float64 `json:"origin_x"`          // X-coordinate position of the obstacle's origin
	OriginY         float64 `json:"origin_y"`          // Y-coordinate position of the obstacle's origin
	Height          float64 `json:"height"`            // Height of the obstacle
	Width           float64 `json:"width"`             // Width of the obstacle
	CloseAreaHeight float64 `json:"close_area_height"` // Height of the close area around the obstacle
	CloseAreaWidth  float64 `json:"close_area_width"`  // Width of the close area around the obstacle
}

// PlayState represents the state of the game at any given moment.
type PlayState struct {
	LevelTime float64    `json:"level_time"` // Time elapsed in the level
	Score     float64    `json:"score"`      // Player's current score
	Player    Player     `json:"player"`     // Current player state
	Obstacles []Obstacle `json:"obstacles"`  // List of obstacles in the game
}
