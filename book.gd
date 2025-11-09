extends Node2D

@onready var left_image_spawn = $Images/LeftImage
@onready var right_image_spawn = $Images/RightImage
@onready var game_logic = %GameLogic

var current_left_page = 0
var pages := []

func _ready():
	for i in game_logic.game_ingredients:
		pages.append(i.correct_item_tex)

	update_page_view()

func previous_page():
	if current_left_page <= 0:
		return
	current_left_page -= 2
	update_page_view()

func next_page():
	if current_left_page + 2 >= pages.size():
		return
	current_left_page += 2
	update_page_view()

func update_page_view():
	# Left page
	if current_left_page < pages.size():
		left_image_spawn.texture = pages[current_left_page]
	else:
		left_image_spawn.texture = null

	# Right page
	var right_index = current_left_page + 1
	if right_index < pages.size():
		right_image_spawn.texture = pages[right_index]
	else:
		right_image_spawn.texture = null

func _process(delta):
	if Input.is_action_just_pressed("left_page"):
		previous_page()
	if Input.is_action_just_pressed("right_page"):
		next_page()
