extends CharacterBody2D

var speed = 0
var wall_left = true
var can_move = false

#Detects if the platform hit a wall
@onready var raycast_left = $RayCast_Left
@onready var raycast_right = $RayCast_Right

#Detects if near a wall
@onready var wallnear_left = $WallNear_Left
@onready var wallnear_right = $WallNear_Right


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	if can_move == true:
		if wallnear_left.is_colliding():
			if wall_left == true:
				speed = -30
				
		if raycast_left.is_colliding():
			speed = 300
			wall_left = false
		
		if wallnear_right.is_colliding():
			if wall_left == false:
				speed = 30
				
		if raycast_right.is_colliding():
			speed = -62
			wall_left = true
		


	velocity = Vector2(speed, 0)
	move_and_slide()


func _on_can_move_body_entered(body):
	if body.name == "CharacterBody2D":
		can_move = true
