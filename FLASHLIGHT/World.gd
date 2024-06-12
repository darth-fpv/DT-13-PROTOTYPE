extends Node3D

@onready var player = $SubViewportContainer/SubViewport/Player

func _physics_process(delta):
			get_tree().call_group("Enemies", "update_target_location", player.global_transform.origin )

	
