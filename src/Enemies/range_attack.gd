extends Area2D

var direction: Vector2 = Vector2.ZERO
var rock_speed: int = 0

func launch (intial_position: Vector2, dir: Vector2, speed: int) -> void:
	position = intial_position
	direction = dir
	rock_speed = speed
	
func _physics_process(delta):
	position += direction * rock_speed * delta
	rotation += 0.2

func _on_body_entered(_body):
	if _body.is_in_group("player"):
		Main.dead.emit()
