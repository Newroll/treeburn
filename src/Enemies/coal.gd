extends CharacterBody2D

var speed = 12.0
var is_moving_left = false
# aggro state
var aggro = false
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	print(speed)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	#Run functions
	move_character()
	move_and_slide()
	detect_turn()

func move_character():
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
		Main.dead.emit()

func _on_player_detection_body_entered(body):
	if body.is_in_group("player"):
		aggro = true
		speed = 50

func _on_player_detection_body_exited(body):
	if body.is_in_group("player"):
		aggro = false
		speed = 12
