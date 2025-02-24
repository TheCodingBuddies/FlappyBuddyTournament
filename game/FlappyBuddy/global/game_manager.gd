extends Node

const game_over_stream : AudioStreamWAV = preload("res://sounds/gameover.wav")
const level_finished_stream: AudioStreamWAV = preload("res://sounds/celebrate.wav")

enum LevelDifficulty {
	CUSTOM,
	EASY,
	MEDIUM,
	HARD,
	SANDBOX
}

var Character: Player

var Score

var score_value: float
var last_score: float
var animation_name
var level_time
var start_sequence_time = 3
var level_speed = 1
var repeat = 1
var repeat_max = 1

var difficulty = LevelDifficulty.EASY

var spawned_obstacles = []
var record_level = false

var last_bot_input = false
var _is_bot = false 

var VIEWPORT_SIZE: Vector2 

func _ready():
	score_value = 0.0
	last_score = 0.0
	level_time = 0
	VIEWPORT_SIZE = get_viewport().get_visible_rect().size

func update_state(player, obstacles):
	var player_size = player.get_collision_rect().size
	var player_obj = {
		"rotation": player.rotation,
		"pos_x": player.position.x,
		"pos_y": player.position.y,
		"width": player_size.x,
		"height": player_size.y,
		"state": player.state,
	}
	var all = {
		"level_time": level_time,
		"score": score_value,
		"player": player_obj,
		"obstacles": []
	}
	for obstacle in obstacles:
		var obstacle_size = obstacle._get_collision_rect().size
		var close_area = obstacle._get_close_area().size
		var collision_origin = Vector2(obstacle.position.x - obstacle_size.x/2, obstacle.position.y - obstacle_size.y/2)
		var data = {
			"type": obstacle._get_name_as_string(),
			"origin_x": collision_origin.x,
			"origin_y": collision_origin.y,
			"width": obstacle_size.x,
			"height":  obstacle_size.y,
			"close_area_width": close_area.x,
			"close_area_height": close_area.y,
		}
		all.obstacles.push_back(data)
	WebsocketServer.send(JSON.stringify(all))

func set_player_animation(animation):
	animation_name = animation	

func set_difficulty(level_difficulty: LevelDifficulty):
	difficulty = level_difficulty

func is_sandbox():
	return difficulty == LevelDifficulty.SANDBOX
	
func is_custom():
	return difficulty == LevelDifficulty.CUSTOM

func is_bot() -> bool:
	return _is_bot
	
func increment_score(delta) -> void:
	score_value += (Engine.physics_ticks_per_second * delta)
	Score.set_text("Score: %d" % score_value)

func add_extra_points(amount: int) -> void:
	score_value += amount
	Score.set_text("Score: %d" % score_value)

func increase_level_time(delta):
	level_time += delta
	
func get_level_time():
	return level_time

func is_start_sequence():
	return level_time < start_sequence_time
	
func add_obstacle_data(obstacle):
	spawned_obstacles.push_back({
			"timestamp": level_time,
			"type": obstacle._get_name_as_string(),
			"origin_x": obstacle.position.x,
			"origin_y": obstacle.position.y,
		})
	
func game_finished() -> void:
	reset_level()
	repeat = repeat - 1
	if repeat <= 0:
		reset_game()
		SoundManager.play(level_finished_stream)
		get_tree().call_deferred("change_scene_to_file", "res://game/level_finished.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", get_tree().current_scene.scene_file_path)

func game_over():
	reset_level()
	repeat = repeat - 1
	if repeat <= 0:
		reset_game()
		SoundManager.play(game_over_stream)
		get_tree().call_deferred("change_scene_to_file", "res://game/game_over.tscn")
	else:
		get_tree().call_deferred("change_scene_to_file", get_tree().current_scene.scene_file_path)
		
func reset_game():
	repeat = repeat_max
	Engine.time_scale = 1
	SoundManager.stop_all()
	SoundManager.set_playback_speed(1)
	_is_bot = false

func reset_level() -> void:
	last_score = score_value
	score_value = 0
	level_time = 0
	if record_level:
		save_last_level()
	record_level = false
	spawned_obstacles = []

func get_control_elements(node):
	var children = []
	for child in node.get_children():
		if child is Button or child is HSlider or child.name == "SanboxButtons":
			children.append(child)
		children += get_control_elements(child)
	return children

func is_mouse_over(elements, mouse_position) -> bool:
	for element in elements:
		if element.get_rect().has_point(mouse_position):
			return true
	return false

var custom_level_name = ""

func save_last_level():
	var json_string = JSON.stringify(spawned_obstacles)
	LevelStorage.save_custom(json_string)
