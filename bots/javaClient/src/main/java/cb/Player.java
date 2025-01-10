package cb;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Player {
    private int height;
    private int width;
    private float posX;
    private float posY;
    private float rotation;

    @JsonCreator
    public Player(@JsonProperty("height") int height,
                  @JsonProperty("width") int width,
                  @JsonProperty("pos_x") float posX,
                  @JsonProperty("pos_y") float posY,
                  @JsonProperty("rotation") float rotation) {
        this.height = height;
        this.width = width;
        this.posX = posX;
        this.posY = posY;
        this.rotation = rotation;
    }

    public int getHeight() {
        return height;
    }

    public int getWidth() {
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

    public void setHeight(int height) {
        this.height = height;
    }

    public void setWidth(int width) {
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
}
