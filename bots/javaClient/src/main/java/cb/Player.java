package cb;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Player {
    private float height;
    private float width;
    private float posX;
    private float posY;
    private float rotation;
    private String state;

    @JsonCreator
    public Player(@JsonProperty("height") float height,
                  @JsonProperty("width") float width,
                  @JsonProperty("pos_x") float posX,
                  @JsonProperty("pos_y") float posY,
                  @JsonProperty("rotation") float rotation,
                  @JsonProperty("state") String state) {
        this.height = height;
        this.width = width;
        this.posX = posX;
        this.posY = posY;
        this.rotation = rotation;
        this.state = state;
    }

    public float getHeight() {
        return height;
    }

    public float getWidth() {
        return width;
    }

    public float getPosX() {
        return posX;
    }

    public float getPosY() {
        return posY;
    }

    public float getRotation() {
        return rotation;
    }

    public String getState() {
        return state;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public void setWidth(float width) {
        this.width = width;
    }

    public void setPosX(float posX) {
        this.posX = posX;
    }

    public void setPosY(float posY) {
        this.posY = posY;
    }

    public void setRotation(float rotation) {
        this.rotation = rotation;
    }

    public void setState(String state) {
        this.state = state;
    }
}
