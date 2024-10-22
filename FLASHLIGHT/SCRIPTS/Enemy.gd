extends CharacterBody3D
@onready var nav_agent = $NavigationAgent3D
@onready var player = "/root/World/SubViewportContainer/SubViewport/Player"
#@onready var player = 1
#calls the navigationagent3D node#
var enemy_speed = 12
var EnemyAcelleration = 12

##raycast variable##
var StateOfEnemy = 1 ## 1: following PLayer, 2: Running, 3: Random Move
var EnemyDetection = false

##enemy pathfinding##
var greatest_distance = Vector3(0,0,0)
var nearby_points = []
var point
var furthest_point
var random_point
var possible_points
	


func _ready():
	$Timer.start()
	furthest_point = get_tree().get_first_node_in_group("ReferencePoints")


##code to toggle between modes, flip flop##
func _physics_process(delta):
	if Input.is_action_just_pressed("Debug_Enemy"):
		$Timer.stop()
		EnemyDetection = false
		if StateOfEnemy == 1:
			_run()
			StateOfEnemy = 2
		elif StateOfEnemy == 2:
			StateOfEnemy = 1
	print(EnemyDetection)
	#print(nearby_points)
	##pathfinding at random##
	point = RandomNumberGenerator.new().randi_range(0, len(nearby_points) - 1)
		
	##enemy movement for direct line of sight.##
	var current_location = global_transform.origin
	#var collider = $VisionRaycast.get_collider()
	
	
	
	
	
	
	
	##Enemy random pathfindg away from the player##
	#possible_points = get_tree().get_nodes_in_group("ReferencePoints")
	#print(possible_points)
	
	#var StateOfEnemy = 1
	#var furthest = vector3
	
	
	
	
	
	##enemy chasing the player
	if StateOfEnemy == 1:
		if EnemyDetection == true:
			StateOfEnemy = 2
		#var next_location = nav_agent.get_next_path_position()
		
	##enemy movement code
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized()*enemy_speed
	#velocity = velocity.lerp(direction * enemy_speed + velocity.y * Vector3.UP , EnemyAcelleration * delta)
	#adds momentum to the enemy movement#
	velocity = velocity.move_toward(new_velocity, .25)
	#velocity = velocity.lerp(direction * enemy_speed + velocity.y * Vector3.UP , EnemyAcelleration * delta)
	var player_distance = global_position.distance_to(get_node(player).global_position)
	print(player_distance)
	if player_distance  <= 2:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/pdiddy.tscn")
	
	move_and_slide()

func update_target_location(target_location):
	#print("tartget_Loccation:")
	#print(target_location)
	nav_agent.set_target_position(target_location)
	
func update_random_position(position_location):
	
	nav_agent.set_target_position(position_location)

func _process(delta):
	pass


func _run():
	#print("This one", nearby_points)
	##looks at the position objects in the array
	if len(nearby_points) > 0:
		for ReferencePoints in nearby_points:
			if ReferencePoints == nearby_points[0]:
				greatest_distance = ReferencePoints.global_position.distance_to(get_node(player).global_position)
				print(greatest_distance)
			#print(ReferencePoints)
			#var distance = get_node("/root/World/SubViewportContainer/SubViewport/Player").distance_to(ReferencePoints)
			var distance = ReferencePoints.global_position.distance_to(get_node(player).global_position)
			
			
			#print(ReferencePoints, ReferencePoints.global_position)
			#print(ReferencePoints, get_node("/root/World/SubViewportContainer/SubViewport/Player").global_position)
			#print(ReferencePoints, distance)
			
			
			##logic for the "furthest "position" object in the radius of the player##
			if distance > greatest_distance:
				greatest_distance = distance
				furthest_point = ReferencePoints
				print("here", furthest_point)
				print(furthest_point.global_position)
			print(greatest_distance)


func _random_point():
	possible_points = get_tree().get_nodes_in_group("ReferencePoints")
	print(possible_points)
	random_point = RandomNumberGenerator.new().randi_range(0, len(possible_points) - 1)
	random_point = possible_points[random_point]
	$Timer.start()




##check if enemy is colliding with the object and changes it's state##
func _on_area_3d_area_entered(area):
	if area.has_meta("point"):
		if area.get_parent() == furthest_point:
			EnemyDetection = false
			_random_point()
			StateOfEnemy = 3
	print("ghi")


func _detect_player():
	if StateOfEnemy == 3:
		$Timer.stop()
		StateOfEnemy = 1


func _on_audio_stream_player_3d_ready():
	AudioStreamMP3
