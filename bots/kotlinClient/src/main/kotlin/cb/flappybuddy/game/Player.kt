package cb.flappybuddy.game

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Player(
    @SerialName("height") val height: Double,
    @SerialName("width") val width: Double,
    @SerialName("pos_x") val posX: Double,
    @SerialName("pos_y") val posY: Double,
    @SerialName("rotation") val rotation: Double,
    @SerialName("state") val state: String,
)
