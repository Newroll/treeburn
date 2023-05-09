extends Area2D

var velocity = Vector2()
var urmom = 0

func _on_body_entered(body):
	urmom = 3

func _physics_process(_delta):
	velocity.y += urmom
