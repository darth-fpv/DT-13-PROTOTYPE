extends RayCast3D
@onready var prompt = $prompt 
@onready var Reticle = $reticle
signal interacted(body)
##checks id the raycast is colliding + debug##
func _physics_process(delta):
	prompt.text = ""
	#if colifding, change prompt text to ----#
	if is_colliding():
		var collider = get_collider()
		#debug#
		print("debug")
		if collider.is_in_group("Buttons"):
			Reticle.visible = true
			if Input.is_action_just_pressed("Interact"):
				collider.pressed = true
				collider._interact()
				print("button pressed")
				#passes the update to the onwner IE the player body, idk lol#
				#collider.interact(owner)
		else:
			Reticle.visible = false
	else:
		Reticle.visible = false
			
		prompt.text = "testing 123"
		
##sending a signal off to 
func interact(body):
	interacted.emit(body)
