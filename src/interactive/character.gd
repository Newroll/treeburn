extends CharacterBody2D

@export var movement_data : MovementData

#Changes the level at which the player respawns along the y axis
var spawnY = -20

#Gets animated sprite and gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var knockback_timer: Timer = get_node("KnockbackTimer")

#Gets knockback direction
var knockback_dir = 0
var knockback_timer_started = false

func _physics_process(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	
	#Makes character move with ground and applys gravity
	player_movement()
	apply_gravity(delta)
	
	if Main.knockback == false:
		#Run functions
		jump()
		check_state()
		wall_sliding_true()
		animation_state()
		handle_acceleration(input_axis, delta)
		apply_friction(input_axis,delta)
	else:
		knockback(input_axis, delta)
	
	if position.y > 100:
		Main.death()
	
	if Main.resetPlayer == true:
		resetPlayerPos()
		Main.resetPlayer = false
	
	Main.playerPosition = get_position()

func check_state():
	if Main.quicksand == true:
		movement_data = load("res://src/interactive/QuicksandMovementData.tres")
	elif Main.ice == true:
		movement_data = load("res://src/interactive/IceMovementData.tres")
	else:
		movement_data = load("res://src/interactive/DefaultMovementData.tres")

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		if !is_on_floor():
			velocity.x = move_toward(velocity.x, movement_data.speed *  input_axis, movement_data.air_resistance * delta)
		else:
			velocity.x = move_toward(velocity.x, movement_data.speed *  input_axis, movement_data.acc * delta)
			
func apply_friction(input_axis, delta):
	if input_axis == 0:
		if !is_on_floor():
			velocity.x = move_toward(velocity.x, 0, movement_data.air_friction * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)

func player_movement():
	move_and_slide()

#Handle Jump.
func jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = movement_data.jump_velocity
		if not is_on_floor() && movement_data.double_jump == true:
			velocity.y = movement_data.jump_velocity * 0.8
			movement_data.double_jump = false

	if is_on_floor():
		movement_data.double_jump = true

#Handles Wall Sliding.
func wall_sliding_true():
	if not is_on_wall():
		movement_data.wall_sliding = false
		return

	if is_on_wall() && not is_on_floor():
		if Input.is_action_just_pressed("interact"):
			movement_data.wall_sliding = true

	if movement_data.wall_sliding == true:
		velocity.y = movement_data.wall_slide
		
	if Input.is_action_just_pressed("move_left") && is_on_wall() && not is_on_floor():
		velocity.y = movement_data.jump_velocity
		velocity.x = 250

	if Input.is_action_just_pressed("move_right") && is_on_wall() && not is_on_floor():
		velocity.y = movement_data.jump_velocity
		velocity.x = -250

func resetPlayerPos():
	get_position()
	if(Main.level == 3):
		spawnY = -130
	else:
		spawnY = -20
	position = Vector2(10,spawnY)
	movement_data.double_jump = true
  
	#Reset Main
	Main.coins = 0
	Main.quicksand = false
	Main.in_range = false
	Main.knockback = false
	Main.health = 3


func animation_state():
	if velocity.x == 0:
		animated_sprite.animation = "default"

	if velocity.x < 0:
		animated_sprite.animation = "move"
		animated_sprite.flip_h = true 

	if velocity.x > 0:
		animated_sprite.animation = "move"
		animated_sprite.flip_h = false 

func knockback(input_axis, _delta):
	if knockback_timer_started == false:
		if input_axis < 0:
			knockback_dir = 1
		else:
			knockback_dir = -1

		velocity.y = -150
		velocity.x = 200 * knockback_dir

		knockback_timer.start()
		knockback_timer_started = true
		print("Timer started")


func _on_knockback_timer_timeout():
	Main.knockback = false
	knockback_timer_started = false
	print("knockback = false!")
	velocity.y = 0
	velocity.x = 0
