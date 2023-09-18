extends CharacterBody2D

var entered = false
var spd = 60
var fallingtime = 0
var wait = false
var waittimer = 200

#Elevator Position
var original_pos = null

func _ready():
	original_pos = get_position()

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
		velocity = Vector2(0, spd)
		move_and_slide()

	if fallingtime > 0 && entered == false:
		if wait == true:
			waittimer -= 1
			if waittimer <= 0:
				wait = false
		else:
			if original_pos.y < position.y:
				spd = -60
				velocity = Vector2(0, spd)
				move_and_slide()
			else:
				spd = 0
				velocity = Vector2(0, spd)
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
