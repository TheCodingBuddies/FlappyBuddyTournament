extends TextureRect

func _ready() -> void:
	if GameManager.is_sandbox():
		self.size = Vector2(32,	32)
		visible = true

func set_obstacle(type):
	var new_texture: Texture2D
	match type:
		Game.ObstacleType.SEAGULL:
			new_texture = load("res://res/gull.png")
		Game.ObstacleType.RAVEN:
			new_texture = load("res://res/raven.png")
		Game.ObstacleType.COIN:
			new_texture = load("res://res/coin.png")
		Game.ObstacleType.FINISH:
			new_texture = load("res://res/finish.png")
	
	self.texture = new_texture
	if type == Game.ObstacleType.COIN or type == Game.ObstacleType.FINISH:
		self.size = Vector2(32,32)
	else:
		self.size = Vector2(64,64)

func _input(event: InputEvent) -> void:
	if not GameManager.is_sandbox():
		return
	if event is InputEventMouseMotion:
		var controls = GameManager.get_control_elements(get_tree().root)
		var mouse_position = get_viewport().get_mouse_position()
		visible = not GameManager.is_mouse_over(controls, mouse_position)
		set_position(mouse_position - get_rect().size / 2)
