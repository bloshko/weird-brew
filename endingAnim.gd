extends Node2D

func _ready() -> void:
	$water.play("water_boil")
	$background.play("on")
	$hand/AnimationPlayer.play("ending_stove_turn_off")
	$hand/AnimationPlayer.connect("animation_finished", _on_hand_animation_finished)

func _on_hand_animation_finished(anim_name: String) -> void:
	if anim_name == "ending_stove_turn_off":
		$drinking.visible = true
		$drinking.play("drinking")
		
		await $drinking.animation_finished
		$drinking.visible = false
		
		$hand/AnimationPlayer.play("handsTransform")
		$hand/AnimationPlayer.connect("animation_finished", _on_transform_animation_finished)

func _on_transform_animation_finished(a) -> void:
		$hand2.visible = false
		$hand.visible = false
		$backgroundDANCE.visible = true
		$backgroundDANCE.play("dance")
