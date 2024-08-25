extends RayCast3D
@onready var prompt = $CanvasLayer/prompt 
@onready var Reticle = $CanvasLayer/reticle

##checks id the raycast is colliding + debug##
func _physics_process(delta):
	prompt.text = ""
	#if colifding, change prompt text to ----#
	if is_colliding():
		var collider = get_collider()
		#debug#
		print("debug")
		if collider is interact:
			prompt.text = collider.prompt_message
			Reticle.visible = true
			if Input.is_action_just_pressed("Interact") and not collider.pressed:
				collider.pressed = true
				print("button pressed")
	else:
		Reticle.visible = false
			
			
		prompt.text = "testing 123"
