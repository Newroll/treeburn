extends CharacterBody2D

var collision_timer = Timer.new()
@onready var collision_shape = $CollisionPolygon2D

func _ready():
	collision_timer.set_wait_time(3.0)
	collision_timer.start()

func _on_timer_timeout():
	if collision_shape.disabled == true:
		collision_shape.disabled = false
		
	if collision_shape.disabled == false:
		collision_shape.disabled = true
