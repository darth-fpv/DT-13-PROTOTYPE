extends CollisionObject3D
class_name interact

@export var prompt_message = "interact"
var pressed = false

func _process(delta):
	print("press", pressed)
