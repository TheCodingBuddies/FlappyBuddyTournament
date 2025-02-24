extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	self.play(0.0)
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_finished():
	self.play(0.0)
	pass # Replace with function body.
