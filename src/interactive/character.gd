extends CharacterBody2D

signal _on_player_death

#Ground Movement 
const SPEED = 150.0
const acc = 500
const friction = 2000

#Set character's jump values
const JUMP_VELOCITY = -300
const air_resistance = 100
var double_jump = true

#Declares wall sliding variables
const wall_pushback = 50
const wall_slide = 10
var wall_sliding = false

var playerposition = Vector2()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	jump()
	player_movement()
	wall_sliding_true()
	player_death()
	animation_state()
	apply_gravity(delta)
	handle_acceleration(input_axis, delta)
	handle_air_resistance(input_axis,delta)
	apply_friction(input_axis,delta)

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_acceleration(input_axis, delta):
	if not is_on_floor():
		return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED *  input_axis, acc * delta)

func apply_friction(input_axis, delta):
	if not is_on_floor():
		return
	if input_axis == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

func handle_air_resistance(input_axis, delta):
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, SPEED * input_axis, air_resistance * delta)

func player_movement():
	move_and_slide()

#Handle Jump.
func jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		if not is_on_floor() && double_jump == true:
			velocity.y = JUMP_VELOCITY * 0.8
			double_jump = false

	if is_on_floor():
		double_jump = true

#Handles Wall Sliding.
func wall_sliding_true():
	if not is_on_wall():
		wall_sliding = false
		return

	if is_on_wall() && not is_on_floor():
		if Input.is_action_just_pressed("interact"):
			wall_sliding = true

	if wall_sliding == true:
		velocity.y = wall_slide
		
	if Input.is_action_just_pressed("move_left") && is_on_wall() && not is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = 150

	if Input.is_action_just_pressed("move_right") && is_on_wall() && not is_on_floor():
		velocity.y = JUMP_VELOCITY
		velocity.x = 150


#Resets player values and position.
func player_death():
	get_position()
	if(position.y > 100):
		position = Vector2(10,-20)
		double_jump = true
		Main.coins = 0
		_on_player_death.emit()

func animation_state():
	if velocity.x == 0:
		animated_sprite.animation = "default"

	if velocity.x < 0:
		animated_sprite.animation = "move"
		animated_sprite.flip_h = true 

	if velocity.x > 0:
		animated_sprite.animation = "move"
		animated_sprite.flip_h = false 


func _on_portal_body_exited(_body):
	pass # Replace with function body.
