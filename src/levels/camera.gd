extends Camera2D

func _process(_delta):
	set_zoom(Vector2(Main.zoomLevels[Main.currentZoomLevel], Main.zoomLevels[Main.currentZoomLevel]))

	if Input.is_action_just_pressed("zoomOut") && Main.currentZoomLevel > 0:
		Main.currentZoomLevel -= 1
	if Input.is_action_just_pressed("zoomIn") && Main.currentZoomLevel < 4:
		Main.currentZoomLevel += 1
