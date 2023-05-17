extends Area2D


var entered = false

func _on_body_entered(_body: PhysicsBody2D):
	entered = true
	$ContinueLable.visible = true


func _on_body_exited(_body):
	entered = false
	$ContinueLable.visible = false

func _process(_delta):
	if entered == true:
		if Input.is_action_just_pressed("enter"):
			get_tree().change_scene_to_file("res://src/levels/level_2.tscn")
