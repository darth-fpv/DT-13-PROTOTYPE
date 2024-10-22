extends ColorRect

@export var target : NodePath
@export var player_path : Node
@export var camdistance = 500

@onready var player = get_node(target)
@onready var camera = $SubViewportContainer/SubViewport/Camera3D
@onready var player_rotation = player.get_child(2)
@onready var pip_rotation = $Pointer_control


func _physics_process(delta: float):
	print(player_rotation)
	if target:
		camera.size = camdistance
		camera.position = Vector3(player.position.x, camdistance, player.position.z)
	var angle = -player_rotation.global_rotation.y
	pip_rotation.rotation = angle
	




#func _input(event):
#	if event is InputEventMouseMotion:
		
