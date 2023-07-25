class_name MovementData

extends Resource

#Set movement variables
@export var speed = 150.0
@export var acc = 500
@export var friction = 2000

#Set character's jump values
@export var jump_velocity = -320
@export var air_resistance = 100
@export var double_jump = true

#Declares wall sliding variables
@export var wall_pushback = 50
@export var wall_slide = 10
@export var wall_sliding = false
