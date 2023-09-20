extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().paused = true
	$die.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("enter"):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://src/levels/demo_level.tscn")
