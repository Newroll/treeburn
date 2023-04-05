extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func go_title_screen():
	get_tree().change_scene_to_file("res://src/intro.tscn")

func _on_animation_player_animation_finished(anim_name):
	go_title_screen()
	pass # Replace with function body.
