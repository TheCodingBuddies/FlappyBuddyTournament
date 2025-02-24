extends ObstacleBehaviour

class_name SeagullBehaviour

func _entry(seagull: Obstacle):
	if randi_range(0, 1) == 0:
		seagull._play_entry_sound()

func _on_player_collide(seagull: Obstacle, player: Player):
	player.state = "died"
	GameManager.update_state(player, [seagull])
	GameManager.game_over()

func _move(delta: float, seagull: Obstacle):
	if seagull.position.x < -50:
		seagull.queue_free()
	else:
		seagull.position.x -= delta * seagull.obstacle_data.speed
		#seagull.position.y -= delta * 20

func _on_player_close_area(seagull: Obstacle, player: Player):
	player.close_enough(seagull.obstacle_data.points)
