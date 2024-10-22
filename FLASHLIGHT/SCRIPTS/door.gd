extends AnimatableBody3D
var buttons_pushed = 0
var buton_num = 0
@export var button : Node
@export var doorstate = 1
var button_num = 0

func _ready():
	button_num = get_tree().get_nodes_in_group("Buttons").size()
	

func _open():
	#toggle mechnaics#
	#if doorstate == 1:
		#$AnimationPlayer.play("door_open")
		#doorstate = 0
	#elif  doorstate == 0:
		#$AnimationPlayer.play("door_close")
		#doorstate = 1
	if button_num > buttons_pushed:
		buttons_pushed += 1
		print("Pushed: " + str(buttons_pushed))
		print("Total: " + str(button_num))

	#multiple buttonpresses#
	if buttons_pushed == button_num:
		$AnimationPlayer.play("door_open")
func _input(event):
	
	if Input.is_action_just_pressed("Door_open"):
		$AnimationPlayer.play("door_open")
		
	if Input.is_action_just_pressed("Door_close"):
		$AnimationPlayer.play("door_close")
