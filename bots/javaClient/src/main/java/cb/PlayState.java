package cb;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class PlayState {
    @JsonProperty("reference_ticks_ms")
    private int refTicks;

    @JsonProperty("player")
    private Player player;

    @JsonProperty("obstacles")
    private List<Obstacle> obstacles;

    public PlayState() {
    }

    public int getRefTicks() {
        return refTicks;
    }

    public void setRefTicks(int refTicks) {
        this.refTicks = refTicks;
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
