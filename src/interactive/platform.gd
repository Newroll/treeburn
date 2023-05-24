extends CharacterBody2D

var entered = false
var spd = 55

func _on_area_2d_body_entered(_body):
	entered = true


func _on_area_2d_body_exited(_body):
	entered = false

func _physics_process(_delta):
	if entered == true:
		spd = spd + 0.5
		await get_tree().create_timer(0.05).timeout
		velocity = Vector2(0, spd)
		move_and_slide()
