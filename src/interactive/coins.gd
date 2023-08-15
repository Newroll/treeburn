extends Node

func _ready():
	self.z_index = -99

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		Main.coins += 1
		#CHANGE THIS!!!
		if Main.worldHealth < 3600:
			Main.worldHealth += 600
		if Main.worldHealth > 3600:
			Main.worldHealth = 3600
		queue_free()
