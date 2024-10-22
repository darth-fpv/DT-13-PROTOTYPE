extends Panel


func _on_new_game_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/MENU.tscn")


func _on_quit_game_pressed():
	get_tree().quit()
