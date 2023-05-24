extends CharacterBody2D

var level_string = ""

func _level_get():
	if Main.level == 1:
		level_string = "/root/Level1/ParallaxBackground/Coins/Coin"
	else:
		level_string = "/root/Level2/ParallaxBackground/Coins/Coin"

@onready var coinnode = $level_string

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
	if Input.is_action_just_pressed("jump") and is_on_floor():
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
	print(position)
	print(playerposition.y)
	if(playerposition.y > 150):
		position = Vector2(10,-20)
		Main.coins = 0
		coinnode.coinvisibilty(true, false)

func _on_portal_body_exited(_body):
	pass # Replace with function body.
