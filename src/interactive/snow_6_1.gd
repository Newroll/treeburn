extends CharacterBody2D


const SPEED = 500
const JUMP_VELOCITY = -400

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var returnTo = get_position()


func _physics_process(delta):
	
	if position.y > -800:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		var direction = -1
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
	get_position()
	
	if position.x < 3020:
		position = Vector2(1000, -1000)
		
	if int(Main.timeEclapsed) % 6 == 0:
		position = Vector2(returnTo.x, returnTo.y)
	
	if position.y > -800:
		move_and_slide();


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		Main.snowHit += 1
