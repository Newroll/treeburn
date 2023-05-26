extends Area2D

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		coinvisibilty(false,true)
		Main.coins += 1
		await get_tree().create_timer(0.4).timeout
		
func coinvisibilty(visibilty, collision):
	self.visible = visibilty
	$CollisionShape2D.set_deferred("disabled", collision)
