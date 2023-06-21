extends CharacterBody2D

signal _on_player_death()

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const wall_pushback = -50
const wall_slide = 10

var jump_counter = 0
var double_jump = false
var wall_sliding = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() && wall_sliding == false:
		velocity.y += gravity * delta
		animated_sprite.animation = "default"
	else:
		jump_counter = 0
		if(velocity.x == 0):
			animated_sprite.animation = "default"
		else:
			animated_sprite.animation = "move"
	
	#wall sliding
	if is_on_wall() && not is_on_floor():
		animated_sprite.animation = "default"
		velocity.x = wall_pushback
		velocity.y = wall_slide
		velocity.y += gravity * delta
	else:
		wall_sliding = false

	# Handle Jump.
	if Input.is_action_just_pressed("jump") && jump_counter < 2:
		jump_counter += 1
		velocity.y = JUMP_VELOCITY
		$AudioStreamPlayer.play()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		
		if(velocity.x < 0): 
			animated_sprite.flip_h = true 
		elif(velocity.x > 0): 
			animated_sprite.flip_h = false 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	
	var playerposition = get_position()
	if(playerposition.y > 100):
		position = Vector2(10,-20)
		double_jump = true
		Main.coins = 0
		_on_player_death.emit()
	
func _on_portal_body_exited(_body):
	pass # Replace with function body.
