extends CharacterBody2D

# Loads throwable rock
const rock_throwable_scene = preload("res://src/Enemies/throwable_rock.tscn")


#Gets player and timer nodes
@onready var player: CharacterBody2D = get_tree().current_scene.get_node("CharacterBody2D")
@onready var attack_timer: Timer = get_node("AttackTimer")
@onready var idle_timer: Timer = get_node("IdleTimer")
@onready var walk_timer: Timer = get_node("WalkTimer")
@onready var bull_timer: Timer = get_node("BullAttackTimer")
@onready var range_timer: Timer = get_node("RangeAttackTimer")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")


# Determines whether or not it can attack
var can_attack = true

#Declares projectile speed
@export var projectile_speed: int = 100


# Movement State
var speed = 18
var is_moving_left = false
var idle = false

#Detects if player is too close
const max_distance_to_player = 80
const min_distance_to_player = 60
var distance_to_player: float

#Chase and Attack state
var aggro = false
var in_range = false
var bull_attack = false
var attack_interval_passed = true
var projectile = rock_throwable_scene.instantiate()

# Raycasts to determine if ground is available for the enemy to walk on
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


#func _ready():
	#animation_player.play("axe_run")


func _physics_process(delta):
	var player_dir = player.position.x - position.x
	distance_to_player = abs(player.position.x - global_position.x)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if can_attack && in_range && bull_attack == false:
		can_attack = false
		_throw_rock()
		attack_timer.start()


	#Stops enemy movement if attacking
	
	if animation_player.current_animation == "coal_attack":
		velocity.x = 0

	#Makes the enemy stay in a certain distance from the player
	#while if there is no where to go to it does a charge attack
	
	if aggro:
		if raycast_left.is_colliding() && raycast_right.is_colliding() && bull_attack == false:
			if distance_to_player > max_distance_to_player:
				move_towards_player(player_dir)

			if distance_to_player < min_distance_to_player:
				move_away_player(player_dir)

			if distance_to_player > min_distance_to_player && distance_to_player < max_distance_to_player:
				velocity.x = 0
		else:
			if !raycast_right.is_colliding() && bull_attack == false:
				bull_attack = true
				velocity.x = -100
				bull_timer.start()

			if !raycast_left.is_colliding() && bull_attack == false:
				bull_attack = true
				velocity.x = 100
				bull_timer.start()

	else:
		detect_turn()
		move_character()
		
	#Run functions
	move_and_slide()
	animation_state()


func move_character():
	if idle == false:
		if is_moving_left == true:
			speed = 18
			velocity.x = speed

		if is_moving_left == false:
			speed = -18
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
		speed = 50
		if player_dir > 0:
			velocity.x = speed
		else:
			velocity.x = speed * -1




func move_away_player(player_dir):
		speed = 40
		if player_dir > 0:
			velocity.x = speed * -1
		else:
			velocity.x = speed


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

#It is only monitoring during bull attack
func _on_death_body_entered(body):
	if body.name == "CharacterBody2D":
		Main.health -= 1
		Main.knockback = true


func _on_ranged_attack_body_entered(body):
	if body.name == "CharacterBody2D":
		in_range = true
		attack_timer.start()


func _on_ranged_attack_body_exited(body):
	if body.name == "CharacterBody2D":
		in_range = false
		attack_timer.stop()


func _on_attack_timer_timeout():
	can_attack = true

func _on_bull_attack_timeout():
	bull_attack = false

func _throw_rock() -> void:
	projectile.launch(global_position, (player.position - global_position).normalized(), projectile_speed)
	get_tree().current_scene.add_child(projectile)
	range_timer.start()


func _on_range_attack_timer_timeout():
	get_tree().current_scene.remove_child(projectile)
	

func hit():
	$attack_area.monitoring = true

func end_hit():
	$attack_area.monitoring = false


func animation_state():
	if not animation_player.current_animation == "coal_attack":
		if velocity.x > 0:
			animated_sprite.flip_h = false
			animated_sprite.play("coal_mov")
		if velocity.x < 0:
			animated_sprite.flip_h = true
			animated_sprite.play("coal_mov")
		if idle or velocity.x == 0:
			animation_player.play("coal_idle")
