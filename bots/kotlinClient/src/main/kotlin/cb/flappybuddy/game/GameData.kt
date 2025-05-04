package cb.flappybuddy.game

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class GameData(
    @SerialName("level_time") val levelTime: Double,
    @SerialName("score") val score: Double,
    @SerialName("player") val player: Player,
    @SerialName("obstacles") val obstacles: List<Obstacle>,
)