extends CharacterBody3D

@export_category("General")


##player variables##
@export var map_vis : Node
@onready var minimap = map_vis

@export var flashlight_delay = .2 #In Seconds#
@export var playerSpeed = 8
@export var jumpforce = 4
@export var playerAcceleration = 5.0
@export var gravity = 9.81 
@export var camera_sensitivity = .5
@export var camera_acceleration = 20

##calling player nodes when starting##
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var flashlight = $Head/Camera3D/Hand/SpotLight3D
var map_state = 0

##enemy detection##
var enemy_node = null

#states the 3 axis coordinates, 
var direction = Vector3.ZERO
var head_y_axix =0.0
var camera_x_axis =0.0

var enemy

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	enemy = get_tree().get_first_node_in_group("Enemies")

##mouse control of the player##
func _input(event):
	if event is InputEventMouseMotion:
		#capture mouse in respect of of x and y axis's
		head_y_axix += event.relative.x *camera_sensitivity
		camera_x_axis += event.relative.y *camera_sensitivity
		#clamps cam angle to 90 and -90 degrees.
		camera_x_axis = clamp(camera_x_axis, -90.0, 90.0)
		
	#closes the game when ESC key is pressed#
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	
##MAP and lighting controls##
	if Input.is_action_just_pressed("map"):
		if map_state == 0:
			flashlight.visible = false
			await get_tree().create_timer(flashlight_delay).timeout
			map_vis.visible = true 
			print("light visible")
			#map_vis = true
			map_state = 1
		elif map_state == 1:
			map_vis.visible = false
			await get_tree().create_timer(flashlight_delay).timeout
			flashlight.visible = true
			#map_vis = false
			
			map_state = 0
	
	
func  _physics_process(delta):
	if map_vis.visible == false :
		#grabs axis, left, right, forward and backwards, then asigns them to vector3(3 axis floating point co-ordinates)
		direction = Input.get_axis("left", "right") * head.basis.x + Input.get_axis("forward", "backward") * head.basis.z
		#creates a lerp/mix form the variable numbers, current velocity to potential maximum velocity, vertical force vecotor aswell.
		#a lerp is a linear interpolation math "function", idk if that's the right word lol. 
		velocity = velocity.lerp(direction * playerSpeed + velocity.y * Vector3.UP , playerAcceleration * delta)
	else:
		velocity.x = 0
		velocity.z = 0
	
	
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
	

##check all overlapping bodies in the cone area##
func _on_flashlight_timer_timeout():
	var overlaps = $"Head/Camera3D/Hand/Flashlight Area".get_overlapping_bodies()
	if overlaps.size() > 0:
		#print(overlaps.size())
		for overlap in overlaps:
			if overlap.is_in_group("Enemies"):
				enemy_node = overlap
				##print("i see you")
				
				var playerPosition = overlap.global_transform.origin
				$VisionRaycast.look_at(playerPosition, Vector3.UP)
				$VisionRaycast.force_raycast_update()
				if map_vis.visible == false:
					
					if $VisionRaycast.is_colliding():
						var collider = $VisionRaycast.get_collider()
					
						if collider.is_in_group("Enemies"):
							if overlap.EnemyDetection == false:
								print("working")
								overlap.EnemyDetection = true
							overlap._run()
							print("detected")
							var EnemyDetection = 1
							print(EnemyDetection)
					
						# HERE
			else:
				print("not detcted")
				var EnemyDetection = 0
				print(EnemyDetection)

##Adds the "ReferenceGroup" objects into a array if the objects enter the radius Area around the player##
func _connect_point(area):
	if area.get_parent().is_in_group("ReferencePoints"):
		enemy.nearby_points.append(area.get_parent())
		print("This is good", enemy.nearby_points)
##removes the objects out of the array if the objects exits the radius Area around the player##
func _disconect_point(area):
	enemy.nearby_points.erase(area.get_parent())

func _enemy_enter_range(area):
	if area.get_parent().has_method("_detect_player"):
		enemy._detect_player()

func _on_area_3d_area_entered(area):
	get_tree().call_deferred("change_scene_to_file", "res://scenes/win_screen.tscn")
