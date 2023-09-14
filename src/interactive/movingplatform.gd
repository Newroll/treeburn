extends CharacterBody2D

var speed = -50.0
var object_left = null
var object_right = null

#Detects if the platform hit a wall
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	if raycast_left.is_colliding():
		object_left = raycast_left.get_collider()
		if object_left.get_name() == "BehindPlayer":
			speed = 30
	
	if raycast_right.is_colliding():
		object_right = raycast_right.get_collider()
		if object_right.get_name() == "BehindPlayer":
			speed = -30

	velocity = Vector2(speed, 0)
	move_and_slide()
