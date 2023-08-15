extends Node

func _ready():
	Main.connect("dead", player_dead)
	# Set the z_index property.
	self.z_index = -99

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		self.visible = false
		$CollisionShape2D.set_deferred("disabled", true)
		Main.coins += 1
		#CHANGE THIS!!!
		if Main.worldHealth < 3600:
			Main.worldHealth += 600
		if Main.worldHealth > 3600:
			Main.worldHealth = 3600
		await get_tree().create_timer(0.4).timeout

func player_dead():
	self.visible = true
	$CollisionShape2D.set_deferred("disabled", false)
