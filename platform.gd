extends CharacterBody2D

var is_fall
var motion = Vector2()

func _physics_process(delta):
	if is_fall == false:
		motion.y += 20
	motion = move_and_slide()



func _on_falling_body_entered(body):
	if body.is_in_group('player'):
		$AnimationPlayer.play("shake")

func fall():
	is_fall = false
