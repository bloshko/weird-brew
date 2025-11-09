extends Node2D

@onready var left_hand = $LeftHand
@onready var left_hand_open_mesh = $LeftHand/OpenHand
@onready var left_hand_closed_mesh = $LeftHand/ClosedHand
@onready var area_to_pick_up = $LeftHand/AreaToPickUpThings
const VELOCITY = 500.0

var closest_item_to_pick_up = null
var item_to_carry = null


func _ready():
	area_to_pick_up.connect("area_entered", _on_item_area_enter)
	area_to_pick_up.connect("area_exited", _on_item_area_exit)

	open_hand()

func close_hand():
	left_hand_open_mesh.visible = false
	left_hand_closed_mesh.visible = true
	
	if closest_item_to_pick_up != null:
		item_to_carry = closest_item_to_pick_up
	

func open_hand():
	left_hand_open_mesh.visible = true
	left_hand_closed_mesh.visible = false
	
	item_to_carry = null

func _process(delta):
	if item_to_carry != null:
		print(item_to_carry.position)
		item_to_carry.global_position = area_to_pick_up.global_position
		print(item_to_carry.position)
		print(area_to_pick_up.position)
		
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
	closest_item_to_pick_up = area.get_parent()

func _on_item_area_exit(area):
	if area.get_parent() == closest_item_to_pick_up:
		closest_item_to_pick_up = null
