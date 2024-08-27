extends AnimatableBody3D

@export var button : Node
		

func _open():
	print("DOOR OPENED")
	$AnimationPlayer.play("door_open")
