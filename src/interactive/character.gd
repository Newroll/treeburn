extends CharacterBody2D

signal _on_player_death

#Set player movement speed along with acceleration and friction to create accurate player movement
const SPEED = 150
const acc = 20
const friction = 30

#Set character's jump power values
const JUMP_VELOCITY = -300
var jump_counter = 0
var max_jumps = 2
var double_jump = false

const wall_pushback = 50
const wall_slide = 10
var wall_sliding = false

var playerposition = Vector2()

var gravity = 1000  # Adjust this as needed
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	playerposition = position

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta

	var input_dir: Vector2 = input()

	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
	else:
		add_friction()
		animated_sprite.animation = "default"

	jump()
	player_movement()

func input() -> Vector2:
	var input_dir = Vector2.ZERO

	input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_dir = input_dir.normalized()
	return input_dir

func accelerate(direction: Vector2) -> void:
	velocity = velocity.move_toward(SPEED * direction, acc)

func add_friction() -> void:
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func player_movement() -> void:
	var horizontal_movement = Vector2(velocity.x, 0)
	var vertical_movement = Vector2(0, velocity.y)


	velocity.x = horizontal_movement.x
	velocity.y = vertical_movement.y
	move_and_slide()

#Handle Jump.
func jump() -> void:
	if is_on_floor():
		jump_counter = 0
	if Input.is_action_just_pressed("ui_accept"):
		if jump_counter < max_jumps:
			velocity.y = JUMP_VELOCITY
			jump_counter += 1
