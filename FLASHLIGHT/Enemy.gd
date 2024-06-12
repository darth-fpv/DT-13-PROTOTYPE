extends CharacterBody3D


@onready var nav_agent = $NavigationAgent3D
#calls the navigationagent3D node#
var speed = 10


func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized()*speed
	velocity = velocity.move_toward(new_velocity, .5)
	
	move_and_slide()

func update_target_location(target_location):
	print("tartget_Loccation:")
	print(target_location)
	nav_agent.set_target_position(target_location)
