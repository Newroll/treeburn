extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("one"):
		Main.coins = 0
		Main.level = 1
		get_tree().change_scene_to_file("res://src/levels/level_1.tscn")
	
	if Input.is_action_just_pressed("two"):
		Main.coins = 0
		Main.level = 2
		get_tree().change_scene_to_file("res://src/levels/level_2.tscn")
	
	if Input.is_action_just_pressed("three"):
		Main.coins = 0
		Main.level = 3
		get_tree().change_scene_to_file("res://src/levels/level_3.tscn")

	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()
