extends Node2D
@onready var time = 0.2
@onready var my_timer  = $Timer


func _ready():
	my_timer.start(time)
	my_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	print("workds")
	get_tree().call_deferred("change_scene_to_file", "res://MENU.tscn")
