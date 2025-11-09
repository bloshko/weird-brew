extends Node2D

var active_map_node = 5

@onready var MAP_NODES = [
	$Map/MapNode1/Area2D,
	$Map/MapNode2/Area2D,
	$Map/MapNode3/Area2D,
	$Map/MapNode4/Area2D,
	$Map/MapNode5/Area2D,
	$Map/MapNode6/Area2D,
]

@onready var lozka = %Lozka
@onready var timer = $Map/MapNodeNodeTouchedTimer
@onready var smoke_anim = $smoke
const DEFAULT_MODULATION = Color.WHITE
const ACTIVE_MODULATION = Color.RED

func _ready():
	$Lozka.connect("area_entered", _on_lozka_area_entered)
	timer.connect("timeout", _on_timer_timeout)
	MAP_NODES[active_map_node].get_parent().modulate = ACTIVE_MODULATION
	_start_timer()
	

func _input(event):
	if event is InputEventMouseMotion:
		lozka.position = event.position
		
func get_next_active_map_node_index():
	var last_index = MAP_NODES.size() - 1
	
	var i = randi_range(0, last_index)
	while i == active_map_node:
		i = randi_range(0, last_index)
	
	return i
	
func activate_node_by_index(index: int):
	active_map_node = index

	for node in MAP_NODES:
		node.get_parent().modulate = DEFAULT_MODULATION
	MAP_NODES[index].get_parent().modulate = ACTIVE_MODULATION
	
	smoke_anim.stop()
	smoke_anim.visible = false
	_start_timer()

func _on_lozka_area_entered(area):
	var parent_name = area.get_parent().name
	if str(active_map_node + 1) in parent_name:	
		var new_index = get_next_active_map_node_index()
		activate_node_by_index(new_index)

func _start_timer():
	timer.stop()
	timer.start()
	
func _on_timer_timeout():
	smoke_anim.visible = true
	smoke_anim.play("smoke")
