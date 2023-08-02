extends CharacterBody2D

var speed = -50.0

@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right
@onready var pos = get_position().y

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	position.y = pos

	if raycast_left.is_colliding():
		speed = 50
	
	if raycast_right.is_colliding():
		speed = -50

	velocity.x = speed
	move_and_slide()
