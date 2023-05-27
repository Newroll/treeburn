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

func _on_player_death():
	if name == "Platformplatform5":
		position = Vector2(7,-2)

	if name == "Platform@platform5":
		position = Vector2(121,-2)

	if name == "Platform@platform4":
		position = Vector2(238,-2)

	if name == "Platform@platform3":
		position = Vector2(358,-2)

	if name == "Platform@platform2":
		position = Vector2(474,-2)

