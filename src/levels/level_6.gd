extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()

func _ready():
	$CanvasLayer/AnimationPlayer.play("fadetonormal")
	await get_tree().create_timer(1).timeout
	$CanvasLayer.hide()
