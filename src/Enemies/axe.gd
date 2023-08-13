extends CharacterBody2D

#Gets player and timer nodes
@onready var player = get_tree().current_scene.get_node("CharacterBody2D")
#@onready var axe: AnimatedSprite2D = get_node(" AnimatedSprite2D")
@onready var attack_timer: Timer = get_node("AttackTimer")
@onready var idle_timer: Timer = get_node("IdleTimer")
@onready var walk_timer: Timer = get_node("WalkTimer")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

# Movement State
var speed = 25
var is_moving_left = false
var idle = false

#Test
var player_axis = 0

var can_attack = false
var aggro = false
var attack_interval_passed = true

# Raycasts to determine if ground is available for the enemy to walk on
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

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

	#Makes the enemy chase the player once it is in range through the aggro var
	move_towards_player(player_dir)
		
	#Run functions
	move_and_slide()
	detect_turn()
	move_character()
	enemy_idle()
	animation_state()


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

func _on_player_chase_body_entered(body):
	if body.name == "CharacterBody2D":
		aggro = true


func _on_player_chase_body_exited(body):
	if body.name == "CharacterBody2D":
		aggro = false

func move_towards_player(player_dir):
	if raycast_left.is_colliding() && raycast_right.is_colliding() && aggro == true:
		if  player_dir <= -1:
			player_axis = -1
		if player_dir >= 1:
			player_axis = 1
		speed = 40 * player_axis


func _on_idle_timer_timeout():
	idle = false
	speed = 25
	walk_timer.start()


func enemy_idle():
	if idle == true:
		velocity.x = 0


func _on_walk_timer_timeout():
	idle = true
	idle_timer.start()


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
		Main.dead.emit()


func _on_attack_timer_timeout():
	attack_interval_passed = true


func animation_state():
	if velocity.x > 0 && not animation_player.current_animation == "axe_attack":
		animated_sprite.flip_h = true
		animation_player.play("axe_run")
	if velocity.x < 0 && not animation_player.current_animation == "axe_attack":
		animated_sprite.flip_h = false
		animation_player.play("axe_run")
	if idle == true:
		animation_player.play("axe_idle")
