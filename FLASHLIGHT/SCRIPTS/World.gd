extends Node3D

@onready var player = $SubViewportContainer/SubViewport/Player
@onready var enemy = $SubViewportContainer/SubViewport/Enimies/Enemy
var possible_points
var point


func _ready():
	possible_points = get_tree().get_nodes_in_group("ReferencePoints")
	print(possible_points)
	point = RandomNumberGenerator.new().randi_range(0, len(possible_points) - 1)
	print(point)
	possible_points[point].global_position
	

##updating the target location
func _physics_process(delta):
	$SubViewportContainer/SubViewport/Label.text = str(enemy.StateOfEnemy)
	if enemy.StateOfEnemy == 1:
		get_tree().call_group("Enemies", "update_target_location", player.global_transform.origin)
	elif enemy.StateOfEnemy == 2:
		get_tree().call_group("Enemies", "update_target_location", enemy.furthest_point.global_transform.origin)
