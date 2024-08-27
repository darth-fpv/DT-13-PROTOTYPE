extends CollisionObject3D
class_name interact

@export var prompt_message = "interact"
var pressed = false
@export var door : Node

func _process(delta):
	print("press", pressed)
	
	
func _interact():
	door._open()
