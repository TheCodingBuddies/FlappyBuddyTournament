extends CharacterBody2D

class_name Player

@onready var animated_sprite = %AnimatedSprite2D
@onready var collision_area: CollisionShape2D = %CollisionShape2D
@export var fabi_sounds: Array[EntrySound]
@export var tino_sounds: Array[EntrySound]


var fabi_close_one: AudioStream = preload("res://sounds/fabi_ohJunge.wav")
var tino_close_one: AudioStream = preload("res://sounds/fabi_contact.wav")

const FLY_VELOCITY = 200
const GRAVITY = 200
var pos_x_start
var pos_x_goal = 80
var state = "start"

func _ready():
	pos_x_start = self.position.x
	GameManager.Character = self
	animated_sprite.animation = GameManager.animation_name
	if animated_sprite.animation == "fabi_animation":
		var random_pick = fabi_sounds.pick_random()
		SoundManager.play(random_pick.call, func(): 
			SoundManager.play(random_pick.answer)
		)
	else:
		var random_pick = tino_sounds.pick_random()
		SoundManager.play(random_pick.call, func(): 
			SoundManager.play(random_pick.answer)
		)

func close_enough(extra_points):
	_play_so_close()
	GameManager.add_extra_points(extra_points)
	
func _play_so_close():
	if animated_sprite.animation == "fabi_animation":
		SoundManager.play(fabi_close_one)
	else:
		SoundManager.play(tino_close_one)
			
func get_collision_rect() -> Rect2:
	return collision_area.shape.get_rect()

func update_initial_player_pos(delta) -> void:
	var transition_step = pos_x_goal - pos_x_start
	var speed = (transition_step/GameManager.start_sequence_time) * delta
	self.position.x = self.position.x + speed
	if self.position.x > 79.5:
		self.position.x = pos_x_goal

func update_position(fly_pressed: bool, delta : float) -> void:
	if fly_pressed:
		position.y += (delta * -FLY_VELOCITY)
		if (rotation > -0.15):
			rotate(-1 * delta)
	else:
		position.y += (delta * GRAVITY)
		if (rotation < 0.05):
			rotate(1 * delta)

func bot_input() -> bool:
	return GameManager.last_bot_input
			
func _physics_process(delta):
	if GameManager.is_start_sequence():
		update_initial_player_pos(delta)
	else:
		GameManager.increment_score(delta)
		if !GameManager.is_bot():
			update_position(Input.is_action_pressed("fly"), delta)
		else:
			update_position(bot_input(), delta)

	move_and_slide()
