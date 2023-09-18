extends CharacterBody2D

var entered = false
var spd = 69
var fallingtime = 0
var wait = false
var waittimer = 200

func _on_collider_body_entered(body):
	if body.name == "CharacterBody2D":
		entered = true

func _on_collider_body_exited(body):
	if body.name == "CharacterBody2D":
		entered = false

func _physics_process(_delta):
	if entered == true:
		wait = true
		waittimer = 120
		fallingtime += 1
		spd += 0.9
		velocity = Vector2(0, spd)
		move_and_slide()
		
	if fallingtime > 0 && entered == false:
		if wait == true:
			waittimer -= 1
			if waittimer <= 0:
				wait = false
				fallingtime -= 1
				spd -= 0.9
				velocity = Vector2(0, spd * -1)
				move_and_slide()
		else:
			fallingtime -= 1
			spd -= 0.8
			velocity = Vector2(0, spd * -1)
			move_and_slide()


#func _on_player_death():
#	if name == "Platformplatform5":
#		position = Vector2(7,-2)
#
#	if name == "Platform@platform5":
#		position = Vector2(121,-2)
#
#	if name == "Platform@platform4":
#		position = Vector2(238,-2)
#
#	if name == "Platform@platform3":
#		position = Vector2(358,-2)
#
#	if name == "Platform@platform2":
#		position = Vector2(474,-2)
