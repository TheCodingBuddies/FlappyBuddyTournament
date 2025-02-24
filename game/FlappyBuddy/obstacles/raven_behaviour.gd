extends ObstacleBehaviour

class_name RavenBehaviour

var iterate = 0
var start_y_position = 0

func _entry(raven: Obstacle):
	if randi_range(0, 1) == 0:
		raven._play_entry_sound()
	start_y_position = raven.position.y

func _on_player_collide(raven: Obstacle, player: Player):
	player.state = "died"
	GameManager.update_state(player, [raven])
	GameManager.game_over()

func _move(delta: float, raven: Obstacle):
	var amp = 50.0
	var freq = 2.0
	var y_offset = (sin(iterate * freq) * amp) - amp/2.0
	#raven.rotate(y_offset/50000 * Engine.time_scale)
	raven.position.y = (start_y_position + y_offset)
	
	iterate += delta
	if raven.position.x < -50:
		raven.queue_free()
	else:
		raven.position.x -= delta * raven.obstacle_data.speed

func _on_player_close_area(raven: Obstacle, player: Player):
	player.close_enough(raven.obstacle_data.points)
