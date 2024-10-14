extends Node3D
@onready var res = DisplayServer.window_get_size()
@onready var player = $SubViewportContainer/SubViewport/Player
@onready var enemy = $SubViewportContainer/SubViewport/Enimies/Enemy
@onready var map_vis = $CanvasLayer/Control/minimap
@onready var flashlight_delay = .2
var map_state = 0
var possible_points
var point


func _ready():
	
	possible_points = get_tree().get_nodes_in_group("ReferencePoints")
	print(possible_points)
	point = RandomNumberGenerator.new().randi_range(0, len(possible_points) - 1)
	print(point)
	possible_points[point].global_position
	print("resoultion of screen", res)
	
	
	

##updating the target location
func _physics_process(delta):
	$SubViewportContainer/SubViewport/Label.text = str(enemy.StateOfEnemy)
	if enemy.StateOfEnemy == 1:
		get_tree().call_group("Enemies", "update_target_location", player.global_transform.origin)
	elif enemy.StateOfEnemy == 2:
		get_tree().call_group("Enemies", "update_target_location", enemy.furthest_point.global_transform.origin)
	elif enemy.StateOfEnemy == 3:
		get_tree().call_group("Enemies", "update_target_location", enemy.random_point.global_transform.origin)
#
#func _input(event):
	#if Input.is_action_just_pressed("map"):
		#if map_state == 0:
			#await get_tree().create_timer(flashlight_delay).timeout
			#map_vis.visible = true
			#
			#map_state = 1
		#elif map_state == 1:
			#
			#map_vis.visible = false
		#
			#map_state = 0
