extends CharacterBody2D

var speed = -30.0

@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	if raycast_left.is_colliding():
		speed = 30
	
	if raycast_right.is_colliding():
		speed = -30
	velocity = Vector2(speed, 0)
	move_and_slide()
