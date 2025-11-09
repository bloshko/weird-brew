extends Node2D

@onready var left_item_spawn = $LeftItemSpawn
@onready var right_item_spawn = $RightItemSpawn

@onready var game_logic = %GameLogic

var ingredient_scene = preload("res://ingridient.tscn")

func spawn_items(correct_item_tex: Texture2D, wrong_item_tex: Texture2D):
	var item_a: Sprite2D = ingredient_scene.instantiate()
	var item_b: Sprite2D = ingredient_scene.instantiate()
	# a - correct
	item_a.is_in_recipe = true
	item_a.texture = correct_item_tex
	
	# b - wrong
	item_b.is_in_recipe = false
	item_b.texture = wrong_item_tex
	
	if randf() >= 0.5:
		# a - wrong
		item_a.is_in_recipe = false
		item_a.texture = wrong_item_tex
		
		# a - correct
		item_b.is_in_recipe = true
		item_b.texture = correct_item_tex

	
	left_item_spawn.add_child(item_a)
	right_item_spawn.add_child(item_b)
	
	
func destroy_items():
	for child in left_item_spawn.get_children():
		child.destroy()
	for child in right_item_spawn.get_children():
		child.destroy()

func _ready():
	spawn_items(game_logic.game_ingredients[0].correct_item_tex, game_logic.game_ingredients[0].wrong_item_tex)
