extends Camera2D

var zoomLevels = [0.1, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2]
var currentZoomLevel = 4

func _process(delta):
	set_zoom(Vector2(zoomLevels[currentZoomLevel], zoomLevels[currentZoomLevel]))
	
	if Input.is_action_just_pressed("zoomIn") && currentZoomLevel > 0:
		currentZoomLevel -= 1
	if Input.is_action_just_pressed("zoomOut") && currentZoomLevel < 8:
		currentZoomLevel += 1
