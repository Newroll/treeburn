extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -350.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite.animation = "default"
	else:
		if(velocity.x == 0):
			animated_sprite.animation = "default"
		else:
			animated_sprite.animation = "move"

	# Handle Jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

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
	if(playerposition.y > 150):
		get_tree().reload_current_scene()
		Main.coins = 0


func _on_portal_body_exited(_body):
	pass # Replace with function body.
