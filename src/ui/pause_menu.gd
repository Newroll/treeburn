extends Control

# NOT WORKING
#func _process(delta):
#	if Input.is_action_just_pressed("esc") && get_tree().paused == true:
#		get_tree().paused = false
#		hide()

func _on_resume_button_pressed():
	get_tree().paused = false
	hide()


func _on_quit_to_desktop_button_pressed():
	get_tree().quit()


func _on_quit_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://src/ui/intro.tscn")
