extends Area2D

var entered = false

func _on_body_entered(_body):
	entered = true
	$ContinueLable.visible = true


func _on_body_exited(_body):
	entered = false
	$ContinueLable.visible = false

func _process(_delta):
	if entered == true && Main.coins == 9 && Input.is_action_just_pressed("enter"):
		Main.coins = 0
		Main.level += 1
		get_tree().change_scene_to_file("res://src/levels/level_2.tscn")
