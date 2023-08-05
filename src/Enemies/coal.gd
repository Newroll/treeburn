extends CharacterBody2D

# Loads throwable rock
const rock_throwable_scene = preload("res://src/Enemies/throwable_rock.tscn")

# Determines whether or not it can attack
var can_attack = false


@export var projectile_speed: int = 100

@onready var player = get_tree().current_scene.get_node("CharacterBody2D")
@onready var attack_timer: Timer = get_node("AttackTimer")
@onready var idle_timer: Timer = get_node("IdleTimer")
@onready var walk_timer: Timer = get_node("WalkTimer")

# Movement State
var speed = 18
var is_moving_left = false
var idle = false

# Raycasts to determine if ground is available for the enemy to walk on
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if can_attack == true && Main.in_range == true:
		can_attack = false
		_throw_rock()

	if Main.aggro == true:
		move_towards_player()

	#Run functions
	move_and_slide()
	move_character()
	detect_turn()
	enemy_idle()


func move_character():
	if idle == false:
		if is_moving_left == true:
			velocity.x = -speed
		else:
			velocity.x = speed


func detect_turn():
	if !raycast_left.is_colliding() && is_on_floor():
		is_moving_left = false
	if !raycast_right.is_colliding() && is_on_floor():
		is_moving_left = true


func _on_death_body_entered(body):
	if body.is_in_group("player"):
		Main.dead.emit()


func _on_ranged_attack_body_entered(body):
	if body.is_in_group("player"):
		Main.in_range = true
		attack_timer.start()


func _on_ranged_attack_body_exited(body):
	if body.is_in_group("player"):
		Main.in_range = false
		attack_timer.stop()


func _on_player_chase_body_entered(body):
	if body.is_in_group("player"):
		Main.aggro = true
		speed = 50


func _on_player_chase_body_exited(body):
	if body.is_in_group("player"):
		Main.aggro = false
		speed = 18

func move_towards_player():
	if raycast_left.is_colliding() && raycast_right.is_colliding() && is_on_floor():
		position.x += (player.position.x - position.x)/speed

func _throw_rock() -> void:
	var projectile = rock_throwable_scene.instantiate()
	projectile.launch(global_position, (player.position - global_position).normalized(), projectile_speed)
	get_tree().current_scene.add_child(projectile)

func _on_attack_timer_timeout():
	can_attack = true


func _on_idle_timer_timeout():
	idle = false
	walk_timer.start()


func enemy_idle():
	if idle == true:
		velocity.x = 0
	else:
		return


func _on_walk_timer_timeout():
	idle = true
	idle_timer.start()
