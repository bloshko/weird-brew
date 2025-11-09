extends Sprite2D

var game_logic = null

var is_in_recipe = false
@export var mp3_res = null

func _ready():
	pass

func set_mp3():
	if mp3_res != null and game_logic != null:
		game_logic.add_mp3(mp3_res)
	
func disolve():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0,0), 0.6)
	tween.tween_callback(set_mp3)
	tween.tween_callback(queue_free)
	
