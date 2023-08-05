extends CharacterBody2D

@export var movement_data : MovementData

var spawnY = -20

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var facingDirection = -1
const KNOCKBACKTIMECONST = 7
var knockbackTime = KNOCKBACKTIMECONST

func _ready():
	Main.connect("dead", player_dead)

func _physics_process(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	if Main.knockback == false:
		jump()
		check_state()
		wall_sliding_true()
		player_death()
		animation_state()
		apply_gravity(delta)
		handle_acceleration(input_axis, delta)
		apply_friction(input_axis,delta)
		player_death()
	knockback(input_axis, delta)
	player_movement()

func check_state():
	if Main.quicksand == true:
		movement_data = load("res://src/interactive/QuicksandMovementData.tres")
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
		velocity.x = 150

	if Input.is_action_just_pressed("move_right") && is_on_wall() && not is_on_floor():
		velocity.y = movement_data.jump_velocity
		velocity.x = 150


#Resets player values and position.
func player_death():
	get_position()
	if(Main.level == 3):
		spawnY = -130
	if (position.y > 100):
		if(Main.level == 3):
			spawnY = -130
		Main.emit_signal("dead")

func player_dead():
	position = Vector2(10,spawnY)
	movement_data.double_jump = true
	#Reset Main
	Main.coins = 0
	Main.quicksand = false
	Main.in_range = false
	Main.aggro = false
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

func knockback(input_axis, delta):
	if Main.knockback == true:
		if input_axis < 0:
			facingDirection = 1
		if input_axis > 0:
			facingDirection = -1
		if knockbackTime > 0:
			velocity.y = -300
			velocity.x = facingDirection * 500
			knockbackTime -= 1
		if knockbackTime <= 0:
			velocity.y = 0
			velocity.x = 0
			knockbackTime = KNOCKBACKTIMECONST
			Main.knockback = false
