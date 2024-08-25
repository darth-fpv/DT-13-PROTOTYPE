extends RayCast3D
@onready var prompt = $CanvasLayer/prompt 
@onready var Reticle = $CanvasLayer/TextureRect

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
			#TextureRect = set_vissible(false)
			
		prompt.text = "testing 123"
