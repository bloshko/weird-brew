extends Node2D

@onready var left_hand = $LeftHand
@onready var left_hand_open_mesh = $LeftHand/OpenHand
@onready var left_hand_closed_mesh = $LeftHand/ClosedHand
const VELOCITY = 500.0

func _ready():
	open_hand()

func close_hand():
	left_hand_open_mesh.visible = false
	left_hand_closed_mesh.visible = true

func open_hand():
	left_hand_open_mesh.visible = true
	left_hand_closed_mesh.visible = false

func _process(delta):
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
