extends AnimatableBody3D

@export var button : Node
@export var doorstate = 1

func _open():
	if doorstate == 1:
		$AnimationPlayer.play("door_open")
		doorstate = 0
	elif  doorstate == 0:
		$AnimationPlayer.play("door_close")
		doorstate = 1
