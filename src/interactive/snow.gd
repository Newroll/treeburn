extends CharacterBody2D


const SPEED = 450.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var returnTo = get_position()
var needToReset = false


func _physics_process(delta):
	
	if position.y > -500:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		var direction = -1
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	get_position()
	
	if position.x < 100:
		position = Vector2(1000, -1000)
		needToReset = true
		
	if Main.levelTimeEclapsed % 6 == 0 && needToReset == true:
		position = Vector2(returnTo.x, returnTo.y)
		needToReset = false
	
	if position.y > -500:
		move_and_slide();
