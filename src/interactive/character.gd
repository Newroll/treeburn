extends CharacterBody2D

signal _on_player_death


#Set player movement speed along with acceleration and friction to create accurate player movement
#Going to try and use acceleration and friction later
const acc = 20
const friction = 30

#Ground Movement for now
const SPEED = 150.0

#Set character's jump power values
const JUMP_VELOCITY = -300
var jump_counter = 0
var max_jumps = 2

#Declares wall sliding variables
const wall_pushback = 50
const wall_slide = 10
var wall_sliding = false

#Declares wall jumping variables
const wall_jump_power = 200
var wall_jumps = 0

var playerposition = Vector2()

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	playerposition = position

func _physics_process(delta):
	velocity.y += gravity * delta

	move()
	jump()
	player_movement()
	wall_sliding_true()
	player_death()
	animation_state()

func move():
	if Input.is_action_just_pressed("move_left"):
		velocity.x = SPEED * -1

	if Input.is_action_just_pressed("move_right"):
		velocity.x = SPEED

	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		velocity.x = 0


func player_movement() -> void:
	move_and_slide()

#Handle Jump.
func jump():
	if Input.is_action_just_pressed("jump"):
		if jump_counter < max_jumps && wall_sliding == false:
			velocity.y = JUMP_VELOCITY
			jump_counter += 1

	if is_on_floor():
		jump_counter = 0
		wall_jumps = 0

#Handles Wall Sliding.
func wall_sliding_true():
	if is_on_wall() && not is_on_floor():
		if Input.is_action_pressed("interact"):
			wall_sliding = true
			velocity.y = wall_slide
			if Input.is_action_just_pressed("move_left"):
				if wall_jumps < max_jumps:
					velocity.y = wall_jump_power
					wall_jumps += 1
					print(wall_jumps)

	if not is_on_wall():
		wall_sliding = false

#Resets player values and position.
func player_death():
	get_position()
	if(position.y > 100):
		position = Vector2(10,-20)
		jump_counter = 0
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
