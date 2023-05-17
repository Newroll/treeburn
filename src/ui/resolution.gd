extends Control

@onready var ResOptionButton = $HBoxContainer/OptionButton

var Resolutions: Dictionary = {"3840x2160":Vector2(3840,2160),
								"2560x1440":Vector2(2560,1440),
								"1920x1080":Vector2(1920,1080),
								"1366x764":Vector2(1366,764),
								"1536x864":Vector2(1536,864),
								"1280x720":Vector2(1280,720),
								"1440x980":Vector2(1440,980),
								"1680x980":Vector2(1680,980),
								"1024x680":Vector2(1024,680)}
func _ready():
	AddResolution()


func AddResolution():
	for r in Resolutions:
		ResOptionButton.add_item(r)
