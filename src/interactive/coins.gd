extends Node

var coins = []

func _ready():
	for child in get_children():
		if child.is_class("Area2D"):
			coins.append(child)

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		$AudioStreamPlayer.play()
		if coins[0].is_class("Area2D"):
			coins[0].visible = false
			coins[0].get_node("collision_shape").disabled = true
		Main.coins += 1
		await get_tree().create_timer(0.4).timeout
		

