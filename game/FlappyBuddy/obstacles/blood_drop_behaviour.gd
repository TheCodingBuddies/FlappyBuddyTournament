extends ObstacleBehaviour

class_name BloodDropBehaviour

func _entry(blood_drop: Obstacle):
	pass

func _on_player_collide(blood_drop: Obstacle, player: Player):
	player.state = "died"
	GameManager.update_state(player, [blood_drop])
	GameManager.game_over()

func _move(delta: float, blood_drop: Obstacle):
	if blood_drop.position.x < -50:
		blood_drop.queue_free()
	else:
		blood_drop.position.x -= delta * blood_drop.obstacle_data.speed
		blood_drop.position.y -= delta * blood_drop.obstacle_data.speed_y

func _on_player_close_area(blood_drop: Obstacle, player: Player):
	player.close_enough(blood_drop.obstacle_data.points)
