extends Area2D

signal stove_turned_on
@onready var knob = $knob

func _input(event):
	if event is InputEventMouseButton and event.pressed and Input.is_action_pressed("left_click"):
		for area in get_overlapping_areas():
			if area.name == "hand":
				emit_signal("stove_turned_on")
				break
