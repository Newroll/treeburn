extends CharacterBody2D
#Get timer node and animated sprite
@onready var reset_timer: Timer = $ResetTimer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

#Get collision shape and area
@onready var death_area: Area2D = $Death
@onready var rock_collision_shape: CollisionShape2D = $CollisionShape2D

#Get raycast that detects if ground is below
@onready var hit_ground: RayCast2D = $hitground

#Get animation player
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var speed = 200
var rock_position = null
var reset_timer_range = null
var fall_ready = null

func _ready():
	rock_position = get_position()

func _physics_process(_delta):
	#animated_sprite.rotation += 0.05
	velocity.y = speed
	velocity.x = 0


	if position == rock_position && !animation_player.current_animation == "shake":
		animated_sprite.visible = false
		death_area.monitoring = false
		rock_collision_shape.disabled = true
	else:
		death_area.monitoring = true
		rock_collision_shape.disabled = false
		animated_sprite.visible = true

	if fall_ready == true && !animation_player.current_animation == "shake":
		speed = 200
		

	move_and_slide()
	on_ground()


func reset_pos():
	position = rock_position
	speed = 0
	fall_ready = false
	reset_timer_range = int(randi_range(3, 7))
	reset_timer.start(reset_timer_range)

func on_ground():
	if hit_ground.is_colliding():
		await get_tree().create_timer(0.3).timeout
		reset_pos()


func _on_death_body_entered(body):
	if body.name == "CharacterBody2D":
		Main.health -= 1
		await get_tree().create_timer(0.3).timeout
		#Main.takeDMG(1)
		reset_pos() 


func _on_reset_timer_timeout():
	animation_player.play("shake")
	fall_ready = true
