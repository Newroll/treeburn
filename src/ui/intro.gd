extends Node2D

func _on_new_game_button_pressed():
	$title.hide()
	$NewGame_Button.hide()
	$Label.show()
	$Letter.show()
	$AnimationPlayer.play("splashscreen_animation")

func _on_animation_player_animation_finished(anim_name):
	$ColorRect.show()
	$AnimationPlayer.play("fadetoblack")
	await get_tree().create_timer(0.7).timeout
	get_tree().change_scene_to_file("res://src/levels/level_0.tscn")
	
