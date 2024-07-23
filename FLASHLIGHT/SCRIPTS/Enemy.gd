extends CharacterBody3D
@onready var player = $SubViewportContainer/SubViewport/Player
@onready var nav_agent = $NavigationAgent3D
#calls the navigationagent3D node#
var speed = 10

##raycast variable##
var StateOfEnemy =1 ## 1: following PLayer, 2: Running, 3: Random Move
var EnemyDetection = false

##enemy pathfinding##
var greatest_distance = Vector3(0,0,0)
var nearby_points = []
var point
var furthest_point
	





##code to toggle between modes, flip flop##
func _physics_process(delta):
	if Input.is_action_just_pressed("Debug_Enemy"):
		if StateOfEnemy == 1:
			_run()
			StateOfEnemy = 2
		elif StateOfEnemy == 2:
			StateOfEnemy = 1
	print(EnemyDetection)
	#print(nearby_points)
	##pathfinding at random##
	#if pathfind.is_colliding():
		#var furthest_point = 0
		#var overlaps = []
		#$RegistraitionArea.append.get_overlapping_bodies()
		#print(overlaps)
	point = RandomNumberGenerator.new().randi_range(0, len(nearby_points) - 1)
	#print(point)
	#possible_points[point].global_position
		
		
		
		
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
	elif StateOfEnemy == 2:
		pass
	elif StateOfEnemy == 3:
		pass
		
	##enemy movement code
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized()*speed
	#adds momentum to the enemy movement#
	velocity = velocity.move_toward(new_velocity, .25)
	
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
				greatest_distance = ReferencePoints.global_position.distance_to(get_node("/root/World/SubViewportContainer/SubViewport/Player").global_position)
				print(greatest_distance)
			#print(ReferencePoints)
			#var distance = get_node("/root/World/SubViewportContainer/SubViewport/Player").distance_to(ReferencePoints)
			var distance = ReferencePoints.global_position.distance_to(get_node("/root/World/SubViewportContainer/SubViewport/Player").global_position)
			
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



func _on_area_3d_area_entered(area):
	pass # Replace with function body.
