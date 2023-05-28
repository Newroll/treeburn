extends Control

@export var game_manager : GameManager

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	game_manager.connect("toggle_game_paused", _on_game_manager_toggle_game_paused)


func _on_game_manager_toggle_game_paused (is_paused : bool):
	if(is_paused):
		show()
	else:
		hide()


func _on_resume_button_pressed():
	game_manager.game_paused = false


func _on_quit_to_desktop_button_pressed():
	get_tree().quit()


func _on_quit_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://src/ui/intro.tscn")
	game_manager.game_paused = false
