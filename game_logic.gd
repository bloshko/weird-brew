extends Node

var game_ingredients: Array[Ingredient] = []
var selected_mp3: Array[String] = []


var current_index = 0
var pages_items = []

const ASSETS  = [
	{"A_tex": "res://assets/ingridients/adam_a.png", "B_tex": "res://assets/ingridients/adam_b.png",
	"A_mp3": "", "B_mp3": ""},
	{"A_tex": "res://assets/ingridients/skull_a.png","B_tex": "res://assets/ingridients/skull_b.png","A_mp3": "", "B_mp3": ""},
	{"A_tex": "res://assets/ingridients/spice_a.png", "B_tex": "res://assets/ingridients/spice_b.png","A_mp3": "", "B_mp3": ""}
]

class Ingredient:
	var correct_item_tex: Texture2D
	var wrong_item_tex: Texture2D
	var name: String
	
	var correct_item_mp3: String
	var wrong_item_mp3: String
	

func _ready():
	generate_ingredients()
	generate_pages_items()

func generate_pages_items():
	for i in game_ingredients:
		pages_items.append(i.correct_item_tex)
		
	pages_items.shuffle()
	
func finish_game():
	get_tree().change_scene_to_file("res://end.tscn")

func start_game():
	%Table.spawn_items(game_ingredients[current_index])
	
func add_mp3(mp3_res):
	selected_mp3.append(mp3_res)
	%Table.destroy_items()
	current_index += 1
	
	if current_index >= game_ingredients.size():
		finish_game()
		return
	
	%Table.spawn_items(game_ingredients[current_index])	
	

func generate_ingredients():
	for ingredient in ASSETS:
		var correct_ingredient_res = ingredient["A_tex"]
		var wrong_ingredient_res = ingredient["B_tex"]
		
		var correct_ignredient_mp3 = ingredient["A_mp3"]
		var wrong_ignredient_mp3 = ingredient["B_mp3"]
		if randf() >= 0.5:
			correct_ingredient_res = ingredient["B_tex"]
			wrong_ingredient_res = ingredient["A_tex"]
			
			correct_ignredient_mp3 = ingredient["B_mp3"]	
			wrong_ignredient_mp3 = ingredient["A_mp3"]
		
		var new_ingredient = Ingredient.new()
		new_ingredient.correct_item_tex = load(correct_ingredient_res)
		new_ingredient.wrong_item_tex = load(wrong_ingredient_res)
		new_ingredient.name = 'test'
		new_ingredient.correct_item_mp3 = correct_ignredient_mp3
		new_ingredient.wrong_item_mp3 = wrong_ignredient_mp3
		
		game_ingredients.append(new_ingredient)

	game_ingredients.shuffle()
