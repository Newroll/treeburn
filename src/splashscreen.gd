extends Node2D


func _input(event):
	if(event.is_action_pressed("skip_animation")):
		go_title_screen()

func go_title_screen():
	get_tree().change_scene_to_file("res://src/intro.tscn")

func _on_animation_player_animation_finished(_splashscreen_animation):
	go_title_screen()
	pass # Replace with function body.

