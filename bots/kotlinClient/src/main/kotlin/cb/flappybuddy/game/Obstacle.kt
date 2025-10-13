package cb.flappybuddy.game

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Obstacle(
    @SerialName("type") val type: String,
    @SerialName("origin_x") var originX: Double,
    @SerialName("origin_y") var originY: Double,
    @SerialName("height") val height: Double,
    @SerialName("width") val width: Double,
    @SerialName("close_area_height") val closeAreaHeight: Double,
    @SerialName("close_area_width") val closeAreaWidth: Double
)
