extends Area2D

var entered = false
var stupid = 1

func _on_body_entered(_body):
	entered = true
	$ContinueLable.visible = true


func _on_body_exited(_body):
	entered = false
	$ContinueLable.visible = false
	$FalseLable.visible = false 

func _process(_delta):
	if stupid == 1: 
		$ContinueLable.visible = false
		$FalseLable.visible = false
		stupid = 0
	if entered == true && Main.coins != 18 && Input.is_action_just_pressed("enter"):
		$FalseLable.visible = true
	if entered == true && Main.coins == 18 && Input.is_action_just_pressed("enter"):
		Main.coins = 0
		Main.level += 1
		get_tree().change_scene_to_file("res://src/levels/level_1.tscn")
