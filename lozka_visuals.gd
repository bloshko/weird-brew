extends Area2D

@onready var spoon_full = preload("res://assets/spoon1.png")
@onready var spoon_dip = preload("res://assets/spoon2.png")

func _ready() -> void:
	$spoon.texture = spoon_full
	
