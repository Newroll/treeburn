extends Node

func _ready():
	# Set the z_index property.
	self.z_index = -99

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		self.visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		Main.coins += 1
		await get_tree().create_timer(0.4).timeout

func _on_player_death():
	self.visible = true
	$CollisionShape2D.set_deferred("disabled", false)
