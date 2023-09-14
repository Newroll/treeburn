extends CharacterBody2D


const SPEED = 500
const JUMP_VELOCITY = -400
var snow_pos = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var returnTo = get_position()
@onready var snowTimer: Timer = $TimeoutTimer
@onready var snowInterval: Timer = $IntervalTimer

func _ready():
	snowTimer.start()


func _physics_process(delta):
	snow_pos = get_position()
	var limit_y: int = returnTo.y + 270
	var limit_x: int = returnTo.x + 530
	
	if not is_on_floor():
		velocity.y += gravity * delta

	velocity.x = SPEED
		
	move_and_slide();
	if snow_pos.y > limit_y:
		position = Vector2(10000, 10000)
	
	if snow_pos.x > limit_x:
		position = Vector2(10000, 10000)


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		Main.snowHit += 1


func _on_timeout_timer_timeout():
	position = Vector2(returnTo.x, returnTo.y)
	snowInterval.start()
	


func _on_interval_timer_timeout():
	snowTimer.start()
