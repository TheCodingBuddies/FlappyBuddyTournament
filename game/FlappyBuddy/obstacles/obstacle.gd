extends Node2D

class_name Obstacle

@onready var collision_shape: CollisionShape2D = $CollisionArea/CollisionShape
@onready var close_shape: CollisionShape2D = $CloseEnoughArea/CloseShape
@onready var entry_sound: AudioStreamPlayer = $EntrySound
@export var obstacle_data: ObstacleData

func _ready():
	obstacle_data = obstacle_data.duplicate(true)
	collision_shape.shape = obstacle_data.collision
	close_shape.shape = obstacle_data.closeArea
	var animation = obstacle_data.animation.instantiate()
	add_child(animation)
	entry_sound.stream = obstacle_data.entry_sound
	obstacle_data.behaviour._entry(self)

func _spawn(data: ObstacleData):
	obstacle_data = data

func _play_entry_sound() -> void:
	entry_sound.play()

func _get_collision_rect() -> Rect2:
	return obstacle_data.collision.get_rect()
	
func _get_close_area() -> Rect2:
	if obstacle_data.closeArea == null:
		return Rect2(Vector2(0, 0), Vector2(0, 0))
	else:
		return obstacle_data.closeArea.get_rect()

func _get_name_as_string() -> String:
	return obstacle_data.obstacle_name

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body is Player:
		obstacle_data.behaviour._on_player_collide(self, body)

func _physics_process(delta: float) -> void:
	obstacle_data.behaviour._move(delta, self)

func _on_close_enough_area_body_entered(body: Node2D) -> void:
	if body is Player:
		obstacle_data.behaviour._on_player_close_area(self, body)
		
