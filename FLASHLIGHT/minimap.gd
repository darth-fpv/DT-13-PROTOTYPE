extends ColorRect

@export var target : NodePath
@export var camdistance = 20

@onready var player = get_node(target)
@onready var camera = $SubViewportContainer/SubViewport/Camera3D

func _physics_process(delta: float):
	if target:
		camera.size = camdistance
		camera.position = Vector3(player.position.x, camdistance, player.position.z)
	
