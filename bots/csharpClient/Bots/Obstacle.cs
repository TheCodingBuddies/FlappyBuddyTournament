using System.Text.Json.Serialization;

namespace CsClient.Bots
{
    public class Obstacle
    {
        [JsonPropertyName("type")]
        public string Type { get; set; }

        [JsonPropertyName("origin_x")]
        public float OriginX { get; set; }

        [JsonPropertyName("origin_y")]
        public float OriginY { get; set; }

        [JsonPropertyName("height")]
        public int Height { get; set; }

        [JsonPropertyName("width")]
        public int Width { get; set; }

        [JsonPropertyName("close_area_height")]
        public int CloseAreaHeight { get; set; }

        [JsonPropertyName("close_area_width")]
        public int CloseAreaWidth { get; set; }

        [JsonConstructor]
        public Obstacle(string type, float originX, float originY, int height, int width, int closeAreaHeight, int closeAreaWidth)
        {
            Type = type;
            OriginX = originX;
            OriginY = originY;
            Height = height;
            Width = width;
            CloseAreaHeight = closeAreaHeight;
            CloseAreaWidth = closeAreaWidth;
        }
    }
}