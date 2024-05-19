extends Node2D


func _process(_delta):
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		$UI/PauseMenu.show()
		
	if $CharacterBody2D.global_position.x > 750:
		var avalancheChildren = $avalanche.get_children()
		for children in avalancheChildren:
			children.queue_free()
			
	if $CharacterBody2D.global_position.x > 1800:
		var avalancheChildrens = $avalanche2.get_children()
		for children in avalancheChildrens:
			children.queue_free()

func _ready():
	$CanvasLayer/AnimationPlayer.play("fadetonormal")
	await get_tree().create_timer(1).timeout
	$CanvasLayer.hide()
