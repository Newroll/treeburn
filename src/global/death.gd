extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_continue_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/levels/level_" + str(Main.level) + ".tscn")
