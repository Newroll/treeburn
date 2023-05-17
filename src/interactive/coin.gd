extends Area2D

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		self.visible = false
		Main.coins += 1
		await get_tree().create_timer(0.4).timeout
		queue_free()
