extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Area2D.connect("stove_turned_on", Callable(self, "_on_stove_turned_on"))
	$background.play("off")
	$water.play("water_still")
	$overlay.play("blinking")
	
func _on_stove_turned_on():
	get_tree().change_scene_to_file("res://main.tscn")

func _input(event):
	if event is InputEventMouseMotion:
		$hand.position = event.position
