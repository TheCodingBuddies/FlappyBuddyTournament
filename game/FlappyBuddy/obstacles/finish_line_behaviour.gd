extends ObstacleBehaviour

class_name FinishLineBehaviour

func _entry(finish: Obstacle):
	pass

func _on_player_collide(finish: Obstacle, player: Player):
	player.state = "finished"
	GameManager.update_state(player, [finish])
	GameManager.game_finished()

func _move(delta: float, finish: Obstacle):
	finish.position.x -= delta * finish.obstacle_data.speed

func _on_player_close_area(finish: Obstacle, player: Player):
	pass
