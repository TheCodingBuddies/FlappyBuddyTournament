extends Node

@onready var sandbox_buttons: HBoxContainer = %SanboxButtons
@onready var shift_left: CheckBox = %CheckBox

signal sandbox_spawn_request(obstacle_data: ObstacleData, position: Vector2)
signal change_obstacle_type(obstacle_type: Game.ObstacleType)

const OBSTACLE = preload("res://obstacles/obstacle.tscn")
const OBSTACLE_DATA_COIN = preload("res://obstacles/obstacle_data_coin.tres")
const OBSTACLE_DATA_RAVEN = preload("res://obstacles/obstacle_data_raven.tres")
const OBSTACLE_DATA_SEAGULL = preload("res://obstacles/obstacle_data_seagull.tres")
const OBSTACLE_DATA_FINISH_LINE = preload("res://obstacles/obstacle_data_finish_line.tres")

var sandbox_obstacle_type: Game.ObstacleType

func _ready() -> void:
	sandbox_obstacle_type = Game.ObstacleType.COIN

func spawn_sandbox_obstacle_at(position: Vector2):
	var sandbox_obstacle
	if shift_left.button_pressed:
		position.x = 850
	match sandbox_obstacle_type:
		Game.ObstacleType.SEAGULL:
			sandbox_spawn_request.emit(OBSTACLE_DATA_SEAGULL, position)
		Game.ObstacleType.RAVEN:
			sandbox_spawn_request.emit(OBSTACLE_DATA_RAVEN, position)
		Game.ObstacleType.COIN:
			sandbox_spawn_request.emit(OBSTACLE_DATA_COIN, position)
		Game.ObstacleType.FINISH:
			position.y = 0 + ProjectSettings.get_setting("display/window/size/viewport_height") / 2
			sandbox_spawn_request.emit(OBSTACLE_DATA_FINISH_LINE, position)
			
func _physics_process(delta: float) -> void:
	if not GameManager.is_start_sequence():
		var controls = GameManager.get_control_elements(get_tree().root)
		var mouse_position = get_viewport().get_mouse_position()
		if Input.is_action_just_pressed("left_click") and not GameManager.is_mouse_over(controls, mouse_position):
			spawn_sandbox_obstacle_at(mouse_position)

func _on_use_seagull_pressed() -> void:
	sandbox_obstacle_type = Game.ObstacleType.SEAGULL
	change_obstacle_type.emit(Game.ObstacleType.SEAGULL)

func _on_use_raven_pressed() -> void:
	sandbox_obstacle_type = Game.ObstacleType.RAVEN
	change_obstacle_type.emit(Game.ObstacleType.RAVEN)

func _on_use_coin_pressed() -> void:
	sandbox_obstacle_type = Game.ObstacleType.COIN
	change_obstacle_type.emit(Game.ObstacleType.COIN)

func _on_use_finish_pressed() -> void:
	sandbox_obstacle_type = Game.ObstacleType.FINISH
	change_obstacle_type.emit(Game.ObstacleType.FINISH)
