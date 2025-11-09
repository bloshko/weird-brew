extends Node2D

@onready var left_item_spawn = $LeftItemSpawn
@onready var right_item_spawn = $RightItemSpawn

@onready var game_logic = %GameLogic

var ingredient_scene = preload("res://ingridient.tscn")
	
func spawn_items(ingredient):
	var item_a: Sprite2D = ingredient_scene.instantiate()
	var item_b: Sprite2D = ingredient_scene.instantiate()
	
	item_a.texture =  ingredient.correct_item_tex
	item_a.mp3_res = ingredient.correct_item_mp3
	item_a.is_in_recipe = true
	
	item_b.texture = ingredient.wrong_item_tex
	item_b.mp3_res = ingredient.wrong_item_mp3
	item_b.is_in_recipe = false

	item_a.game_logic = game_logic
	item_b.game_logic = game_logic

	
	if randf() >= 0.5:
		left_item_spawn.add_child(item_a)
		right_item_spawn.add_child(item_b)
	else:
		left_item_spawn.add_child(item_b)
		right_item_spawn.add_child(item_a)
	
func destroy_items():
	for child in left_item_spawn.get_children():
		child.queue_free()
	for child in right_item_spawn.get_children():
		child.queue_free()

func _ready():
	game_logic.start_game()
