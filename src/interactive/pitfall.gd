extends CharacterBody2D

var entered = false

func _on_collider_body_entered(_body):
	entered = true

func _on_collider_body_exited(_body):
	entered = false

func _physics_process(_delta):
	if entered == true:
		$AnimationPlayer.play("wobble")
		await get_tree().create_timer(0.5).timeout
		queue_free()		
