extends CanvasLayer

func _on_button_pressed():
	print("hi")
	get_tree().paused = true
	$PauseMenu.show()
