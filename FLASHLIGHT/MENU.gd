extends Node2D

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Saves/map.tscn")
