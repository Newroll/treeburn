extends CharacterBody2D

var entered = false
var spd = 0.2

func _on_area_2d_body_entered(_body):
	entered = true


func _on_area_2d_body_exited(_body):
	entered = false

func _physics_process(_delta):
	if entered == true:
		await get_tree().create_timer(0.05).timeout
		velocity = Vector2(0, 75)
		move_and_slide()
