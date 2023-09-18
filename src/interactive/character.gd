extends CharacterBody2D

@export var movement_data : MovementData

#Changes the level at which the player respawns along the y axis
var spawnY = -20

#Gets animated sprite and gravity
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_collision: CollisionPolygon2D = $CollisionShape2D
@onready var knockback_timer: Timer = get_node("KnockbackTimer")
@onready var fireKnockback_timer: Timer = get_node("FireKnockbackTimer")

#Get raycasts for wall jump
@onready var wall_right: RayCast2D = $Wall_Right
@onready var wall_left: RayCast2D = $Wall_Left

#Get raycasts for knockback
@onready var knockback_right: RayCast2D= $Knockback_Right
@onready var knockback_left: RayCast2D = $Knockback_Left
@onready var knockback_down: RayCast2D = $Knockback_Down

#Raycast collider
var object_down = null
var object_right = null
var object_left = null

var facingDirection = -1
const KNOCKBACKTIMECONST = 7
var knockbackTime = KNOCKBACKTIMECONST

#Gets knockback direction
var knockback_dir = 0
var knockback_power = -200
var knockback_timer_started = false
var fireKnockback_timer_started = false

var stupidAnimation

func _physics_process(delta):
	var input_axis = Input.get_axis("move_left", "move_right")
	
	if knockback_right.is_colliding():
		object_right = knockback_right.get_collider()
		
	if knockback_left.is_colliding():
		object_left = knockback_left.get_collider()
		
	if knockback_down.is_colliding():
		object_down = knockback_down.get_collider()

	#Makes character move with ground and applys gravity
	player_movement()
	check_state()
	apply_gravity(delta)
	
	if Main.suspendMovement == true:
		velocity.x = 0
	
	if Main.knockback == false && Main.fireKnockback == false && Main.suspendMovement == false:
		#Run functions
		jump()
		#wall_sliding_true()
		animation_state(input_axis)
		handle_acceleration(input_axis, delta)
		apply_friction(input_axis,delta)
		wall_jumping()
	elif Main.knockback == true:
		knockback()
	elif Main.fireKnockback == true:
		fireKnockback(input_axis, delta)
	
	if position.y > Main.death_height[Main.level] && Main.demo == false:
		Main.below_death_height = true
	
	if Main.demo == true && position.y > Main.demo_death_height:
		Main.below_death_height = true
	
	if Main.resetPlayer == true:
		velocity.y = 0
		velocity.x = 0
		animated_sprite.animation = "death"
		await get_tree().create_timer(1.9).timeout
		resetPlayerPos()
		Main.resetPlayer = false
	
	Main.playerPosition = get_position()

func check_state():
	if Main.quicksand == true:
		movement_data = load("res://src/interactive/QuicksandMovementData.tres")
		animated_sprite.set_speed_scale(0.26)
	if Main.ice == true:
		movement_data = load("res://src/interactive/IceMovementData.tres")
		animated_sprite.set_speed_scale(0.5)
	if Main.ice == false && Main.quicksand == false:
		movement_data = load("res://src/interactive/DefaultMovementData.tres")
		animated_sprite.set_speed_scale(1.0)

func apply_gravity(delta):
	if not is_on_floor() && movement_data.wall_sliding == false:
		velocity.y += gravity * delta


func handle_acceleration(input_axis, delta):
	if input_axis != 0:
		if !is_on_floor():
			velocity.x = move_toward(velocity.x, movement_data.speed *  input_axis, movement_data.air_resistance * delta)
		else:
			await get_tree().create_timer(0.1).timeout if Main.ice == true else await get_tree().create_timer(0).timeout
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
			await get_tree().create_timer(0.1).timeout if Main.ice == true else await get_tree().create_timer(0).timeout
			velocity.y = movement_data.jump_velocity
			$AudioStreamPlayer.play()

		if not is_on_floor() && movement_data.double_jump == true:
			velocity.y = movement_data.jump_velocity * 0.8
			$AudioStreamPlayer.play()
			movement_data.double_jump = false

	if is_on_floor():
		movement_data.double_jump = true


#Handles Wall Sliding.
func wall_sliding_true():
	if is_on_wall() && not is_on_floor():
		if Input.is_action_just_pressed("interact"):
			movement_data.wall_sliding = true
		
		if movement_data.wall_sliding:
			if Input.is_action_just_pressed("KEY_ANY"):
				movement_data.wall_sliding = false

		if movement_data.wall_sliding == true:
			velocity.y = movement_data.wall_slide
	else:
		movement_data.wall_sliding = false
		return


func wall_jumping():
	#For some reason "is_on_wall" is breaking this code.
	if not is_on_floor():
		if Input.is_action_just_pressed("move_right"):
			if wall_left.is_colliding():
				var object_left_wall = wall_left.get_collider()
				if object_left_wall.get_name() == "BehindPlayer":
					velocity.y = movement_data.jump_velocity
					velocity.x = 150

		if Input.is_action_just_pressed("move_left"):
			if wall_right.is_colliding():
				var object_right_wall = wall_right.get_collider()
				if object_right_wall.get_name() == "BehindPlayer":
					velocity.y = movement_data.jump_velocity
					velocity.x = -150


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
	Main.knockback = false
	Main.health = 3


func animation_state(input_axis):
	if velocity.x == 0 && Main.resetPlayer == false:
		animated_sprite.animation = "default"
		animated_collision.scale.y = 0.951
		animated_collision.position.x = 0.1

	if input_axis == -1:
		animated_sprite.animation = "move"
		animated_sprite.flip_h = true 
		animated_collision.scale.y = 1.03
		animated_collision.position.x = -3

	if input_axis == 1:
		animated_sprite.animation = "move"
		animated_collision.scale.y = 1.03
		animated_collision.position.x = 1.5
		animated_sprite.flip_h = false 

	if velocity.y < 0:
		animated_sprite.animation = "jumpUp"
		
	if velocity.y > 0:
		animated_sprite.animation = "jumpDown"

	if Main.immunity == true && Main.health > 0:
		stupidAnimation = true

	if Main.hurtSFX == false:
		Main.hurtSFX = true
		if Main.health > 0:
			$hurt.play()
		else: 
			$die.play()

	if stupidAnimation == true:
		$AnimationPlayer.play("blink")
		stupidAnimation = false

func knockback():
	if knockback_timer_started == false:
# Identifies whether or not knockback is coming from the right
		if knockback_right.is_colliding():
			if object_right.get_name() != "BehindPlayer":
				knockback_dir = -1
				knockback_power = -200

# Identifies whether or not knockback is coming from the left
		if knockback_left.is_colliding():
			if object_left.get_name() != "BehindPlayer":
				knockback_dir = 1
				knockback_power = -200

# Identifies whether or not knockback is coming from both left and right
#Function not needed right now
		#if knockback_left.is_colliding() && knockback_right.is_colliding():
			#if object_left.get_name() != "BehindPlayer" && object_right.get_name() != "BehindPlayer": 
				#if object_down.get_name() == "BehindPlayer":
					#knockback_dir = 0
					#knockback_power = -350
					#print("Knockback down")

# Identifies whether or not knockback is coming from below
		if knockback_down.is_colliding():
			if object_down.get_name() != "BehindPlayer":
					knockback_dir = randi_range(-1, 1)
					knockback_power = -350
					print("Knockback down (raycast_down)")

		velocity.x = 150 * knockback_dir
		velocity.y = knockback_power

		knockback_timer.start()
		knockback_timer_started = true

func _on_knockback_timer_timeout():
	Main.knockback = false
	knockback_timer_started = false
	velocity.y = 0
	velocity.x = 0

func fireKnockback(input_axis, _delta):
	if fireKnockback_timer_started == false:
		if input_axis < 0:
			knockback_dir = 1
		else:
			knockback_dir = -1

		velocity.y = -150
		velocity.x = 200 * knockback_dir

		fireKnockback_timer.start()
		fireKnockback_timer_started = true
		print("Timer started")


func _on_fire_knockback_timer_timeout():
	Main.fireKnockback = false
	fireKnockback_timer_started = false
	velocity.y = 0
	velocity.x = 0
