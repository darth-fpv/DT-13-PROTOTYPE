extends Node3D

@export var button : Node

func _process(delta):
	if button.pressed:
		print("YEP")
