extends Node

var coins = []

func _ready():
for child in get_children():
	if child.is_class("Area2D"):
		coins.append(child)

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		coinvisibilty(false, true)
		Main.coins += 1
		await get_tree().create_timer(0.4).timeout
		#queue_free()
		
func coinvisibilty(visibilty, collision):
	self.visible = visibilty
	$CollisionShape2D.set_deferred("disabled", collision)
