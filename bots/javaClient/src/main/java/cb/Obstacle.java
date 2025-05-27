package cb;


import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class Obstacle {
    private String type;
    private float originX;
    private float originY;
    private float height;
    private float width;
    private int closeAreaHeight;
    private int closeAreaWidth;

    @JsonCreator
    public Obstacle(
            @JsonProperty("type") String type,
            @JsonProperty("origin_x") float originX,
            @JsonProperty("origin_y") float originY,
            @JsonProperty("height") float height,
            @JsonProperty("width") float width,
            @JsonProperty("close_area_height") int closeAreaHeight,
            @JsonProperty("close_area_width") int closeAreaWidth) {
        this.type = type;
        this.originX = originX;
        this.originY = originY;
        this.height = height;
        this.width = width;
        this.closeAreaHeight = closeAreaHeight;
        this.closeAreaWidth = closeAreaWidth;
    }

    public String getType() {
        return type;
    }

    public float getOriginX() {
        return originX;
    }

    public float getOriginY() {
        return originY;
    }

    public float getHeight() {
        return height;
    }

    public float getWidth() {
        return width;
    }

    public int getCloseAreaHeight() {
        return closeAreaHeight;
    }

    public int getCloseAreaWidth() {
        return closeAreaWidth;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setOriginX(float originX) {
        this.originX = originX;
    }

    public void setOriginY(float originY) {
        this.originY = originY;
    }

    public void setHeight(float height) {
        this.height = height;
    }

    public void setWidth(float width) {
        this.width = width;
    }

    public void setCloseAreaHeight(int closeAreaHeight) {
        this.closeAreaHeight = closeAreaHeight;
    }

    public void setCloseAreaWidth(int closeAreaWidth) {
        this.closeAreaWidth = closeAreaWidth;
    }
}
