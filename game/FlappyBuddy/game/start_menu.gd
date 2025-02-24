extends CanvasLayer
@onready var bot_name: Label = $HumanOrBot/VBoxContainer/BotName
@onready var play_mode: CheckButton = $HumanOrBot/VBoxContainer/HBoxContainer/PlayMode
@onready var level_name = $Panel/LevelName
@onready var level_selection = $LevelSelection
@onready var level_list = $LevelSelection/LevelList
@onready var port: SpinBox = %port
@onready var level_repeat: SpinBox = %LevelRepeat

var player_animation: String
var level_difficulty: GameManager.LevelDifficulty

func _ready():
	level_selection.visible = false
	level_difficulty = GameManager.LevelDifficulty.EASY
	player_animation = "tino_animation"
	port.set_block_signals(true)
	port.value = WebsocketServer.port
	port.set_block_signals(false)
	level_repeat.value = GameManager.repeat_max

func _physics_process(_delta: float) -> void:
	bot_name.set_text(WebsocketServer.connected_bot_name)

func _on_tino_select_pressed() -> void:
	player_animation = "tino_animation"

func _on_fabi_select_pressed() -> void:
	player_animation = "fabi_animation"
	
func _on_easy_pressed() -> void:
	level_difficulty = GameManager.LevelDifficulty.EASY
	
func _on_medium_pressed() -> void:
	level_difficulty = GameManager.LevelDifficulty.MEDIUM

func _on_hard_pressed() -> void:
	level_difficulty = GameManager.LevelDifficulty.HARD
	
func _on_sandbox_pressed() -> void:
	level_difficulty = GameManager.LevelDifficulty.SANDBOX
	
func _on_custom_pressed() -> void:
	level_list.clear()
	level_difficulty = GameManager.LevelDifficulty.CUSTOM
	var level_names = LevelStorage.get_available_level()
	for level in level_names:
		level_list.add_item(level)
	level_selection.visible = true

func _on_record_level_toggled(toggled_on: bool) -> void:
	GameManager.record_level = toggled_on

func _on_start_button_pressed() -> void:
	GameManager.set_difficulty(level_difficulty)
	GameManager.set_player_animation(player_animation)
	get_tree().change_scene_to_file("res://game/game.tscn")

func _on_play_mode_toggled(toggled_on: bool) -> void:
	GameManager._is_bot = toggled_on
	if toggled_on and not WebsocketServer.has_connection():
		play_mode.button_pressed = false

func _on_level_name_text_changed():
	LevelStorage.name_to_save = level_name.text

func _on_level_selection_cancel_pressed():
	level_selection.visible = false
	
func _on_level_selection_button_pressed():
	level_selection.visible = false

func _on_level_list_item_selected(index):
	LevelStorage.name_to_load = LevelStorage.get_available_level()[index]

func _on_spin_box_value_changed(value: float) -> void:
	GameManager.repeat = value
	GameManager.repeat_max = value

func _on_port_value_changed(value: float) -> void:
	WebsocketServer.restart_server_on(value)
