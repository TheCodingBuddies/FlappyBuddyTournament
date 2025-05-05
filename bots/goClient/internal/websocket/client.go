package websocket

import (
	"bytes"
	"encoding/json"
	"log"
	"strconv"

	"flappybuddy-bot/internal/bot"
	"flappybuddy-bot/internal/model"

	"github.com/gorilla/websocket"
)

// Client represents a client that communicates with the game server via WebSocket.
type Client struct {
	Conn     *websocket.Conn      // The WebSocket connection
	Bot      bot.Bot              // The bot that interacts with the game
	Port     int                  // The port number to connect to
	Messages chan model.PlayState // Channel to receive PlayState messages from the server
}

// NewClient initializes a new Client with the provided bot, port, and buffer size.
func NewClient(bot bot.Bot, port int, buffer int) *Client {
	return &Client{
		Bot:      bot,
		Port:     port,
		Messages: make(chan model.PlayState, buffer), // Create a channel with the specified buffer size
	}
}

// Connect establishes the WebSocket connection to the server using the bot's name and the specified port.
func (c *Client) Connect() error {
	// Construct the URL for the WebSocket connection
	url := "ws://localhost:" + strconv.Itoa(c.Port) + "/" + c.Bot.GetName()

	// Establish the WebSocket connection
	conn, _, err := websocket.DefaultDialer.Dial(url, nil)
	if err != nil {
		// Return error if connection fails
		return err
	}

	// Store the WebSocket connection
	c.Conn = conn
	return nil
}

// Listen listens for incoming WebSocket messages from the server.
func (c *Client) Listen() {
	for {
		// Read the raw message from the WebSocket connection
		_, rawMessage, err := c.Conn.ReadMessage()
		if err != nil {
			// Log and exit if an error occurs while reading the message
			log.Println("Error reading message:", err)
			return
		}

		// fmt.Println("Raw Message Received:", string(rawMessage))

		// Use a JSON decoder to unmarshal the raw message into the PlayState struct
		decoder := json.NewDecoder(bytes.NewReader(rawMessage))
		var state model.PlayState
		err = decoder.Decode(&state)
		if err != nil {
			// If the message is not valid JSON (e.g. a ping), handle it appropriately
			log.Println("got ping message")
			continue
		}

		// Send the decoded PlayState to the channel to be processed later
		c.Messages <- state
	}
}

// ProcessMessages processes incoming messages from the message channel and sends actions back to the server.
func (c *Client) ProcessMessages() {
	for {
		// Wait for a new PlayState message from the channel
		state := <-c.Messages

		// Run the bot's logic to determine the next action (fly or not)
		action := c.Bot.Run(&state)

		// Send the action (true or false for flying) back to the server in JSON format
		err := c.Conn.WriteJSON(map[string]bool{"fly": action})
		if err != nil {
			// Log error if there is a problem sending the message
			log.Println("Error sending message:", err)
			return
		}
	}
}

// Close closes the WebSocket connection when done.
func (c *Client) Close() {
	// Close the WebSocket connection
	c.Conn.Close()
}
