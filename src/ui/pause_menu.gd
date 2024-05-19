extends CanvasLayer

# NOT WORKING
#func _process(delta):
#	if Input.is_action_just_pressed("esc") && get_tree().paused == true:
#		get_tree().paused = false
#		hide()

func _on_resume_button_pressed():
	get_tree().paused = false
	hide()


func _on_quit_menu_button_pressed():
	get_tree().paused = false
	Main.coins = 0
	get_tree().change_scene_to_file("res://src/ui/intro.tscn")


func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/levels/level_" + str(Main.level) + ".tscn")
