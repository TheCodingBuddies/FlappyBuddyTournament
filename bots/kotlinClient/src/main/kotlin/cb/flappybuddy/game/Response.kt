package cb.flappybuddy.game

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Response(
    @SerialName("fly") val fly: Boolean
)