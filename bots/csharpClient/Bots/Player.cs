using System.Text.Json.Serialization;

namespace CsClient.Bots
{
    public class Player
    {
        [JsonPropertyName("height")]
        public int Height { get; set; }

        [JsonPropertyName("width")]
        public int Width { get; set; }

        [JsonPropertyName("pos_x")]
        public float PosX { get; set; }

        [JsonPropertyName("pos_y")]
        public float PosY { get; set; }

        [JsonPropertyName("rotation")]
        public float Rotation { get; set; }

        [JsonPropertyName("state")]
        public string State { get; set; }

        [JsonConstructor]
        public Player(int height, int width, float posX, float posY, float rotation, string state)
        {
            Height = height;
            Width = width;
            PosX = posX;
            PosY = posY;
            Rotation = rotation;
            State = state;
        }
    }
}