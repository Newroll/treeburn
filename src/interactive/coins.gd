extends Node

func _ready():
	self.z_index = -99

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		self.visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		Main.coins += 1
		if Main.worldHealth < 3600:
			Main.worldHealth += 600
		if Main.worldHealth > 3600:
			Main.worldHealth = 3600
		await get_tree().create_timer(0.4).timeout
		queue_free()
