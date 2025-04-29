extends Node2D

class_name Game

@export var level: Level

@onready var range_debug = $Range_Debug
@onready var countdown_label: Label = %Time
@onready var timer: Timer = $Timer
@onready var obstacle_hover: TextureRect = $ObstacleHover
@onready var speed_label: Label = $SpeedLabel
@onready var tries_left: Label = %TriesLeft
@onready var flyer_name: Label = %FlyerName
@onready var speed: HSlider = $Speed

const SANDBOX = preload("res://game/sandbox.tscn")

const LEVEL_EASY = preload("res://game/level_easy.tres")
const LEVEL_MEDIUM = preload("res://game/level_medium.tres")
const LEVEL_HARD = preload("res://game/level_hard.tres")
const LEVEL_CUSTOM = preload("res://game/level_custom.tres")

const OBSTACLE = preload("res://obstacles/obstacle.tscn")
const OBSTACLE_DATA_COIN = preload("res://obstacles/obstacle_data_coin.tres")
const OBSTACLE_DATA_SEAGULL = preload("res://obstacles/obstacle_data_seagull.tres")
const OBSTACLE_DATA_RAVEN = preload("res://obstacles/obstacle_data_raven.tres")
const OBSTACLE_DATA_FINISH_LINE = preload("res://obstacles/obstacle_data_finish_line.tres")
const OBSTACLE_DATA_VAMPIRE_COW = preload("res://obstacles/obstacle_data_vampire_cow.tres")

enum ObstacleType {
	SEAGULL,
	RAVEN,
	COIN,
	FINISH
}

var level_runtime = 0
var elapsed_enemy_time = 0
var elapsed_collectable_time = 0
var current_enemy_frequency = 4
var current_collectable_frequency = 2

var last_y_position = 0
var min_distance = 100

var coin_generator: CoinGenerator
var loaded_level = []
var has_started = false

func _ready() -> void:
	flyer_name.set_text("%s" % WebsocketServer.get_bot_name())
	tries_left.set_text("%dx left" % GameManager.repeat)
	coin_generator = CoinGenerator.new()
	set_level()
	speed_label.text = "%.2f" % Engine.time_scale
	speed.value = Engine.time_scale
	
	if GameManager.is_custom():
		loaded_level = LevelStorage.load_custom()
		return
		
	if GameManager.is_sandbox():
		var sandbox = SANDBOX.instantiate()
		add_child(sandbox)
		sandbox.sandbox_spawn_request.connect(spawn)
		sandbox.change_obstacle_type.connect(func(type): obstacle_hover.set_obstacle(type))
		return
		
	timer.wait_time = level.time_in_sec + GameManager.start_sequence_time
	timer.timeout.connect(spawn_finish)
	timer.start()

func set_level() -> void:
	match GameManager.difficulty:
		GameManager.LevelDifficulty.EASY:
			level = LEVEL_EASY
		GameManager.LevelDifficulty.MEDIUM:
			level = LEVEL_MEDIUM
		GameManager.LevelDifficulty.HARD:
			level = LEVEL_HARD
		_:
			level = LEVEL_CUSTOM

func spawn_enemy() -> void:
	var enemy_data
	if randi_range(0, 3) == 0:
		enemy_data = OBSTACLE_DATA_RAVEN
	else:
		enemy_data = OBSTACLE_DATA_SEAGULL
		
	var x = 800 - (randi() % 50)
	var y = calculate_fair_spawn_y(enemy_data)
	last_y_position = y
	var enemy_position = Vector2(x, y)
	spawn(enemy_data, enemy_position)

func calculate_spawn_rate() -> void:
	var time_factor = int(level_runtime / 30.0) * 0.1
	var score_factor = int(GameManager.score_value / level.point_increase) * level.freq_increase_rate
	var dynamic_spawn_rate = level.start_spawn_freq -time_factor - score_factor
	current_enemy_frequency = max(dynamic_spawn_rate, level.max_spawn_freq)

func calculate_fair_spawn_y(enemy: ObstacleData):
	var max_y_position = GameManager.VIEWPORT_SIZE.y - enemy.collision.get_rect().size.y
	var min_y_position = 0
	var gap_size = calculate_gap_size()
	var gap_start = randf_range(min_y_position, max_y_position - gap_size)
	var gap_end = gap_start + gap_size

	var spawn_y_position = randf_range(min_y_position, max_y_position)
	while spawn_y_position > gap_start and spawn_y_position < gap_end:
		spawn_y_position = randf_range(min_y_position, max_y_position)
	
	return spawn_y_position

func calculate_gap_size():
	var player_height = get_player().get_collision_rect().size.y
	var min_gap = player_height + 2*20        # (rate_up + rate_down) * 0.5
	return max(min_gap, player_height * 1.5)  # Mindestens 1,5-fache Spielerhöhe als Lücke

func spawn_collectable() -> void:
	var rand_pattern = randi() % 4
	var coin_positions = coin_generator.get_coin_pattern(rand_pattern)
	for pos in coin_positions: 
		spawn(OBSTACLE_DATA_COIN, pos)
	
func update_game_state() -> void:
	var obstacles = self.get_children().filter(func(child): return child is Obstacle)
	GameManager.update_state(get_player(), obstacles)

func get_player():
	var player = self.get_children().filter(func(child): return child is Player)[0]
	if not has_started:
		has_started = true
	else:
		player.state = 'alive'
	return player

func spawn_from_file() -> void:
	while loaded_level.size() > 0 and loaded_level[0].timestamp <= GameManager.level_time:
		var first = loaded_level.pop_front()
		var pos =  Vector2(first.origin_x, first.origin_y)
		var obstacle
		match(first.type):
			"Coin":
				spawn(OBSTACLE_DATA_COIN, pos)
			"Raven":
				spawn(OBSTACLE_DATA_RAVEN, pos)
			"Seagull":
				spawn(OBSTACLE_DATA_SEAGULL, pos)
			"Finish":
				spawn(OBSTACLE_DATA_FINISH_LINE, pos)
			"VampireCow":
				spawn(OBSTACLE_DATA_VAMPIRE_COW, pos)

func process_game(delta) -> void:
	if GameManager.is_custom():
		spawn_from_file()
		return
	
	if elapsed_enemy_time >= current_enemy_frequency:
		if randi() % 4 != 0:
			spawn_enemy()
		elapsed_enemy_time = 0
	else:
		elapsed_enemy_time += delta
		
	if elapsed_collectable_time >= current_collectable_frequency:
		spawn_collectable()
		elapsed_collectable_time = 0
	else:
		elapsed_collectable_time += delta
	calculate_spawn_rate()

func _run_start_sequence() -> void:
	if GameManager.get_level_time() > 1:
		countdown_label.set_text("2")
	if GameManager.get_level_time() > 2:
		countdown_label.set_text("1")

func _physics_process(delta) -> void:
	if GameManager.is_start_sequence():
		_run_start_sequence()
	else:
		countdown_label.visible = false
		if not GameManager.is_sandbox():
			process_game(delta)
			level_runtime += delta
		update_game_state()
	GameManager.increase_level_time(delta)

func spawn(obstacle_data: ObstacleData, position: Vector2, speed_y: int = 0) -> void:
	var new_obstacle = OBSTACLE.instantiate()
	if speed_y != 0:
		obstacle_data.speed_y = speed_y
	new_obstacle.obstacle_data = obstacle_data
	new_obstacle.position = position
	GameManager.add_obstacle_data(new_obstacle)
	self.add_child(new_obstacle)

func spawn_finish():
	var spawn_position = Vector2(GameManager.VIEWPORT_SIZE.x + 50, GameManager.VIEWPORT_SIZE.y/2)
	spawn(OBSTACLE_DATA_FINISH_LINE, spawn_position)

func _on_speed_value_changed(value: float) -> void:
	speed_label.text = "%.2f" % value
	Engine.time_scale = value
	if value > 0:
		SoundManager.set_mute(SoundManager.sound_muted)
		SoundManager.set_playback_speed(value)
	else:
		SoundManager.set_mute(true)
