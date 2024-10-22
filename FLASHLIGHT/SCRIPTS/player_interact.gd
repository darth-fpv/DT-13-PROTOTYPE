extends CollisionObject3D
class_name interact

@export var prompt_message = "interact"
@export var door : Node
var pressed = false
var button_state = false

func _process(delta):
	print("press", pressed)
	
	
func _interact():
	if button_state == false:
		door._open()
		button_state = true
