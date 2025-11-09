extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$background.play("on")
	$hourglass.play("hourglass")
	$water.play("water_boil")
