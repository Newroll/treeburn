extends Area2D

func _on_body_entered(body):
	print("entered quicksand")
	Main.quicksand = true

func _on_body_exited(body):
	print("exited quicksand")
	Main.quicksand = false
