extends Area2D

@onready
var camera = get_node("Camera2D")

func _on_body_entered(body):
	camera.limit_top = -200;
