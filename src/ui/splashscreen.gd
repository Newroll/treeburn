extends Node2D


func _input(event):
	if(event.is_action_pressed("enter")):
		get_tree().change_scene_to_file("res://src/ui/intro.tscn")

func _on_animation_player_animation_finished(splashscreenAnimation):
	get_tree().change_scene_to_file("res://src/ui/intro.tscn")

