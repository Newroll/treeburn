extends CharacterBody2D

#Gets player and timer nodes
@onready var player = get_tree().current_scene.get_node("CharacterBody2D")
#@onready var axe: AnimatedSprite2D = get_node(" AnimatedSprite2D")
@onready var attack_timer: Timer = get_node("AttackTimer")
@onready var idle_timer: Timer = get_node("IdleTimer")
@onready var walk_timer: Timer = get_node("WalkTimer")

# Movement State
var speed = 25
var is_moving_left = false
var idle = false

var can_attack = false
var attack_interval_passed = true

# Raycasts to determine if ground is available for the enemy to walk on
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if can_attack && attack_interval_passed:
		$AnimationPlayer.play("axe_attack")
		attack_interval_passed = false
		attack_timer.start()
	
	#Stops enemy movement if attacking
	if $AnimationPlayer.current_animation == "axe_attack":
		velocity.x = 0

	#Makes the enemy chase the player once it is in range through the aggro var
	if Main.aggro == true:
		move_towards_player()

	#Run functions
	move_and_slide()
	move_character()
	detect_turn()
	enemy_idle()
	#animation_state()


func move_character():
	if idle == false:
		if is_moving_left == true:
			velocity.x = -speed
		else:
			velocity.x = speed


func detect_turn():
	if !raycast_left.is_colliding() && is_on_floor or is_on_wall():
		is_moving_left = false
	if !raycast_right.is_colliding() && is_on_floor() or is_on_wall():
		is_moving_left = true

func _on_player_chase_body_entered(body):
	if body.is_in_group("player"):
		Main.aggro = true
		speed = 40


func _on_player_chase_body_exited(body):
	if body.is_in_group("player"):
		Main.aggro = false
		speed = 25

func move_towards_player():
	if raycast_left.is_colliding() && raycast_right.is_colliding() && is_on_floor():
		position.x += (player.position.x - position.x)/speed


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


func hit():
	$attack_area.monitoring = true

func end_hit():
	$attack_area.monitoring = false


func _on_can_attack_body_entered(body):
	if body.is_in_group("player"):
		can_attack = true


func _on_attack_area_body_entered(body):
	if body.is_in_group("player"):
		Main.dead.emit()


func _on_attack_timer_timeout():
	attack_interval_passed = true


#func animation_state():
	#if velocity.x > 0:
		#axe.flip_h = true
	#if velocity.x < 0:
		#axe.flip_h = false
