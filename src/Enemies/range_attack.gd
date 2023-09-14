extends Area2D

var direction: Vector2 = Vector2.ZERO
var rock_speed: int = 0

func launch (intial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = intial_position
	direction = dir
	rock_speed = speed
	
func _physics_process(delta):
	position += direction * rock_speed * delta
	rotation += 1

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		Main.knockback = true
		Main.takeDmg(1)
