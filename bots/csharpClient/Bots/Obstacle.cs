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
        public float Height { get; set; }

        [JsonPropertyName("width")]
        public float Width { get; set; }

        [JsonPropertyName("close_area_height")]
        public float CloseAreaHeight { get; set; }

        [JsonPropertyName("close_area_width")]
        public float CloseAreaWidth { get; set; }

        [JsonConstructor]
        public Obstacle(string type, float originX, float originY, float height, float width, float closeAreaHeight, float closeAreaWidth)
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