extends CanvasLayer
@onready var score: Label = %Score


func _ready() -> void:
	score.set_text("Score: %d" % GameManager.last_score)

func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_start_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://game/start_menu.tscn")
