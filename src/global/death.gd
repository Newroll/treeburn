extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	Main.health = 3
	$die.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("enter"):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://src/levels/level_" + str(Main.level) + ".tscn")


func _on_continue_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/levels/level_" + str(Main.level) + ".tscn")


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://src/ui/intro.tscn")
