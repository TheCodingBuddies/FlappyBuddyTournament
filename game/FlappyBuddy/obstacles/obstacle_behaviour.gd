extends Resource

class_name ObstacleBehaviour

func _entry(obstacle: Obstacle):
	printerr("IF CAN SEE THIS YOU MISSED AN ENTRY IMPLEMENTATION")

func _on_player_collide(obstacle: Obstacle, player: Player):
	printerr("IF CAN SEE THIS YOU MISSED A COLLIDE IMPLEMENTATION")

func _move(delta: float, obstacle: Obstacle):
	printerr("IF CAN SEE THIS YOU MISSED A MOVE IMPLEMENTATION")

func _on_player_close_area(obstacle: Obstacle, player: Player):
	printerr("IF CAN SEE THIS YOU MISSED A CLOSE AREA IMPLEMENTATION")
