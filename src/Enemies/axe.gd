extends CharacterBody2D

#Gets player and timer nodes
@onready var player: CharacterBody2D = get_tree().current_scene.get_node("CharacterBody2D")
@onready var attack_timer: Timer = get_node("AttackTimer")
@onready var idle_timer: Timer = get_node("IdleTimer")
@onready var walk_timer: Timer = get_node("WalkTimer")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

#Detects if wall is left or right
@onready var is_wall_left: RayCast2D = get_node("IsWall_Left")
@onready var is_wall_right: RayCast2D = get_node("IsWall_Right")

# Raycasts to determine if ground is available for the enemy to walk on
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Movement State
var speed = 25
var is_moving_left = false
var idle = false

#Chase and Attack state
var has_hit = false
var can_attack = false
var aggro = false
var attack_interval_passed = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	animation_player.play("axe_run")


func _physics_process(delta):
	var player_dir = player.position.x - position.x
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta


	if can_attack == true && attack_interval_passed == true:
		animation_player.play("axe_attack")
		attack_interval_passed = false
		attack_timer.start()


	#Stops enemy movement if attacking
	if animation_player.current_animation == "axe_attack":
		velocity.x = 0
	else:
		#Makes the enemy chase the player once it is in range through the aggro var
		if aggro:
			move_towards_player(player_dir)
		else:
			detect_turn()
			move_character()
		
	#Run functions
	move_and_slide()
	animation_state()
	is_wall_blocking()


func is_wall_blocking():
	if is_wall_left.is_colliding():
		var wall_left = is_wall_left.get_collider()
		if wall_left.get_name() == "BehindPlayer":
			if aggro:
				velocity.x = 0
			else:
				is_moving_left = true

	if is_wall_right.is_colliding():
		var wall_right = is_wall_right.get_collider()
		if wall_right.get_name() == "BehindPlayer":
			if aggro:
				velocity.x = 0
			else:
				is_moving_left = false

func move_character():
	if idle == false:
		if is_moving_left == true:
			speed = 35
			velocity.x = speed

		if is_moving_left == false:
			speed = -35
			velocity.x = speed


func detect_turn():
	if !raycast_left.is_colliding():
		is_moving_left = true

	if !raycast_right.is_colliding():
		is_moving_left = false

func _on_player_chase_body_entered(body):
	if body.name == "CharacterBody2D":
		aggro = true


func _on_player_chase_body_exited(body):
	if body.name == "CharacterBody2D":
		aggro = false

func move_towards_player(player_dir):
	if raycast_left.is_colliding() && raycast_right.is_colliding():
		speed = 70
		if player_dir > 0:
			velocity.x = speed
		else:
			velocity.x = speed * -1
	else:
		velocity.x = 0


func _on_idle_timer_timeout():
	idle = false
	walk_timer.start()


func _on_walk_timer_timeout():
	if aggro == false:
		idle = true
		velocity.x = 0
		idle_timer.start()
	else: 
		walk_timer.start()


func hit():
	$attack_area.monitoring = true

func end_hit():
	$attack_area.monitoring = false


func _on_can_attack_body_entered(body):
	if body.name == "CharacterBody2D":
		can_attack = true


func _on_can_attack_body_exited(body):
	if body.name == "CharacterBody2D":
		can_attack = false


func _on_attack_area_body_entered(body):
	if body.name == "CharacterBody2D":
		if has_hit == false:
			Main.takeDmg(1)
			attack_interval_passed = false
			Main.knockback = true
			has_hit = true


func _on_attack_timer_timeout():
	attack_interval_passed = true
	has_hit = false


func animation_state():
	if not animation_player.current_animation == "axe_attack":
		if velocity.x > 0:
			animated_sprite.flip_h = true
			animation_player.play("axe_run")
		if velocity.x < 0:
			animated_sprite.flip_h = false
			animation_player.play("axe_run")
		if idle or velocity.x == 0:
			animation_player.play("axe_idle")
