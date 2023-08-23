extends Node2D


func _input(event):
	if(event.is_action_pressed("skip_animation")):
		get_tree().change_scene_to_file("res://src/levels/level_0.tscn")

#func _on_animation_player_animation_finished(_splashscreen_animation):
#	get_tree().change_scene_to_file("res://src/levels/level_0.tscn")

