extends ObstacleBehaviour

class_name CoinBehaviour

const collected_coins_sound = preload("res://sounds/coin.wav")

func _entry(coin: Obstacle):
	pass

func _on_player_collide(coin: Obstacle, player: Player):
	SoundManager.play(collected_coins_sound)
	GameManager.add_extra_points(coin.obstacle_data.points)
	coin.queue_free()

func _move(delta: float, coin: Obstacle):
	if coin.position.x < -50:
		coin.queue_free()
	else:
		coin.position.x -= delta * coin.obstacle_data.speed

func _on_player_close_area(coin: Obstacle, player: Player):
	pass
