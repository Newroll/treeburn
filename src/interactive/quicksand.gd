extends Area2D

func _on_body_entered(body):
	Main.quicksand = true

func _on_body_exited(body):
	Main.quicksand = false
