extends Node
@onready var pause_panel: Panel = %PausePanel

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var esc_pressed = Input.is_action_just_pressed("pause")
	if esc_pressed:
		get_tree().paused = true
		pause_panel.show()

func _on_continue_pressed() -> void:
	pause_panel.hide()
	get_tree().paused = false


func _on_exit_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_level()
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://game/start_menu.tscn")
