extends Area2D

var entered = false
var pressed = false

func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		entered = true
		$enter.visible = true


func _on_body_exited(_body):
	entered = false
	$enter.visible = false
	$coins.visible = false
	
func _ready():
	#$coins.set_text("You will need " + str(Main.coinRequirement[Main.level]) + " coins")
	if Main.level == 2:
		$enter.set_position(Vector2(2, -35))
		$coins.set_position(Vector2(5, -17))

func _process(_delta):
	if entered == true && Input.is_action_just_pressed("enter") && pressed == false:
		pressed = true
		$coins.visible = true
		Main.coins = 0
		Main.level += 1
		Main.worldHealth = 8
		$CanvasLayer.show()
		$CanvasLayer/AnimationPlayer.play("fadetoblack")
		await get_tree().create_timer(0.7).timeout
		get_tree().change_scene_to_file("res://src/levels/level_"+str(Main.level)+".tscn")
