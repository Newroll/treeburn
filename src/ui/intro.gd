extends Node2D

func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://src/ui/splashscreen.tscn")
