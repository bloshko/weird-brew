extends Node2D

@onready var left_hand = $LeftHand
@onready var left_hand_open_mesh = $LeftHand/OpenHand
@onready var left_hand_closed_mesh = $LeftHand/ClosedHand
@onready var area_to_pick_up = $LeftHand/AreaToPickUpThings
@onready var soup_area = %SoupArea

const VELOCITY = 500.0

var closest_item_to_pick_up = null
var item_to_carry = null

var is_hand_above_soup = false


func _ready():
	area_to_pick_up.connect("area_entered", _on_item_area_enter)
	area_to_pick_up.connect("area_exited", _on_item_area_exit)
	
	soup_area.connect("area_shape_entered", _on_soup_area_enter)
	soup_area.connect("area_shape_exited", _on_soup_area_exit)

	open_hand()

func close_hand():
	left_hand_open_mesh.visible = false
	left_hand_closed_mesh.visible = true
	
	if closest_item_to_pick_up != null:
		item_to_carry = closest_item_to_pick_up
	

func open_hand():
	left_hand_open_mesh.visible = true
	left_hand_closed_mesh.visible = false
	
	if is_hand_above_soup and item_to_carry != null:
		item_to_carry.disolve()

	item_to_carry = null

func _process(delta):
	if item_to_carry != null:
		item_to_carry.global_position = area_to_pick_up.global_position
		
	if Input.is_action_just_pressed("pick_up"):
		close_hand()
	elif Input.is_action_just_released("pick_up"):
		open_hand()

	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		velocity.y += VELOCITY
	if Input.is_action_pressed("move_up"):
		velocity.y -= VELOCITY
	if Input.is_action_pressed("move_left"):
		velocity.x -= VELOCITY
	if Input.is_action_pressed("move_right"):
		velocity.x += VELOCITY
	
	left_hand.position += velocity * delta

func _on_item_area_enter(area):
	var area_parent = area.get_parent()
	if area_parent.has_method('disolve'):
		$LeftHand/holdLabel.visible = true
		closest_item_to_pick_up = area.get_parent()

func _on_item_area_exit(area):
	if area.get_parent() == closest_item_to_pick_up:
		$LeftHand/holdLabel.visible = false
		closest_item_to_pick_up = null

func _on_soup_area_enter(a,b,c,d):
	is_hand_above_soup = true
	
func _on_soup_area_exit(a,b,c,d):
	is_hand_above_soup = false
