extends CharacterBody3D

@export_category("General")


##player variaubles##
@export var playerSpeed = 8
@export var jumpforce = 8.0
@export var playerAcceleration = 5.0
@export var gravity = 9.81
@export var camera_sensitivity = 2
@export var camera_acceleration = 20
##calling player nodes when starting##
@onready var head = $Head
@onready var camera = $Head/Camera3D

##enemy detection##
@export var EnemyDetection = 0

#states the 3 axis coordinates, 
var direction = Vector3.ZERO
var head_y_axix =0.0
var camera_x_axis =0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		#capture mouse in respect of of x and y axis's
		head_y_axix += event.relative.x *camera_sensitivity
		camera_x_axis += event.relative.y *camera_sensitivity
		#clamps cam angle to 90 and -90 degrees.
		camera_x_axis = clamp(camera_x_axis, -90.0, 90.0)
	
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func  _physics_process(delta):
	#grabs axis, left, right, forward and backwards, then asigns them to vector3(3 axis floating point co-ordinates)
	direction = Input.get_axis("left", "right") * head.basis.x + Input.get_axis("fowrdward", "backward") * head.basis.z
	#creates a lerp/mix form the variable numbers, current velocity to potential maximum velocity, vertical force vecotor aswell.
	#a lerp is a linear interpolation math "function", idk if that's the right word lol. 
	velocity = velocity.lerp(direction * playerSpeed + velocity.y * Vector3.UP , playerAcceleration * delta)
	
	
	# adds a lerp(linear interpolation) to the rotation of the cam we have recorded and outputs it into acelleration of the cam movement.
	head.rotation.y = lerp(head.rotation.y, -deg_to_rad(head_y_axix), camera_acceleration * delta)
	camera.rotation.x = lerp(camera.rotation.x, -deg_to_rad(camera_x_axis), camera_acceleration * delta)
	
	# only can jump if on floor.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jumpforce
	else:
		velocity.y -= gravity * delta
		
	
	
	move_and_slide()
	# Add the gravity.
	
	#terms to remeber:
			#delta = time in respect to the last passed frame, used for physics and functions.
			#Vector3 = declairing a plane with 3 dimentional coordinate properties.  
			#lerp = liner interpolation, used for velocity and accelleration changes 

##check all overlapping bodies in the cone area##
func _on_flashlight_timer_timeout():
	var overlaps = $"Head/Camera3D/Hand/Flashlight Area".get_overlapping_bodies()
	if overlaps.size() > 0:
		print(overlaps.size())
		for overlap in overlaps:
			if overlap.is_in_group("Enemies"):
				##print("i see you")
				
				var playerPosition = overlap.global_transform.origin
				$VisionRaycast.look_at(playerPosition, Vector3.UP)
				$VisionRaycast.force_raycast_update()
				
				if $VisionRaycast.is_colliding():
					var collider = $VisionRaycast.get_collider()
					
					if collider.is_in_group("Enemies"):
						print("detected")
						var EnemyDetection = 1
						print(EnemyDetection)
			else:
				print("not detcted")
				var EnemyDetection = 0
				print(EnemyDetection)
