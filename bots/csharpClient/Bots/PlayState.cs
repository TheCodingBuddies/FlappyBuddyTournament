using System.Text.Json.Serialization;

namespace CsClient.Bots
{
    /// <summary>
    /// Antwortdata vom Server bzgl. game data
    /// </summary>
    public class PlayState
    {
        [JsonPropertyName("reference_ticks_ms")]
        public int RefTicks { get; set; }
        
        [JsonPropertyName("player")]
        public Player Player { get; set; }

        [JsonPropertyName("obstacles")]
        public List<Obstacle> Obstacles { get; set; }

        public PlayState()
        {
        }

        public PlayState(int refTicks,Player player, List<Obstacle> obstacles)
        {
            RefTicks = refTicks;
            Player = player;
            Obstacles = obstacles;
        }
    }
}