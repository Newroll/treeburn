extends Node2D

func _ready():
	get_tree().paused = false
	Main.coins = 0
	Main.level = 0
	Main.timeEclapsed = 0
	Main.worldHealth = 3600
	Main.gameComplete = true
	Main.health = 3


func _on_new_game_button_pressed():
	#$title.hide()
	#$NewGame_Button.hide()
	#$creditsbutton.hide()
	#$Label.show()
	#$Letter.show()
	#$AnimationPlayer.play("splashscreen_animation")
	
	#I made it that the splashscreen happens on launch instead of on new game
	get_tree().change_scene_to_file("res://src/levels/level_0.tscn")


func _on_creditsbutton_pressed():
	get_tree().change_scene_to_file("res://src/ui/credits.tscn")
