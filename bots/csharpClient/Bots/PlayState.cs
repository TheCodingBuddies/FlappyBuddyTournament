using System.Text.Json.Serialization;

namespace CsClient.Bots
{
    /// <summary>
    /// Antwortdata vom Server bzgl. game data
    /// </summary>
    public class PlayState
    {
        [JsonPropertyName("level_time")]
        public float LevelTime { get; set; }

        [JsonPropertyName("score")]
        public float Score { get; set; }
        
        [JsonPropertyName("player")]
        public Player Player { get; set; }

        [JsonPropertyName("obstacles")]
        public List<Obstacle> Obstacles { get; set; }

        public PlayState()
        {
        }

        public PlayState(float levelTime, float score, Player player, List<Obstacle> obstacles)
        {
            LevelTime = levelTime;
            Score = score;
            Player = player;
            Obstacles = obstacles;
        }
    }
}