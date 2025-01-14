package cb;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class PlayState {
    @JsonProperty("level_time")
    private float levelTime;

    @JsonProperty("player")
    private Player player;

    @JsonProperty("obstacles")
    private List<Obstacle> obstacles;

    public PlayState() {
    }

    public float getLevelTime() {
        return levelTime;
    }

    public void setLevelTime(float levelTime) {
        this.levelTime = levelTime;
    }

    public Player getPlayer() {
        return this.player;
    }

    public void setPlayer(Player player) {
        this.player = player;
    }

    public List<Obstacle> getObstacles() {
        return this.obstacles;
    }

    public void setObstacles(List<Obstacle> obstacles) {
        this.obstacles = obstacles;
    }
}
