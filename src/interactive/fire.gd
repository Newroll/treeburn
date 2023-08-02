extends Area2D

var isInFire = false
var immuneTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	self.z_index = -99


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isInFire == true && immuneTimer == 0 && Main.health > 0:
		Main.knockback = true
		Main.health -= 1
		immuneTimer = 120
	if immuneTimer > 0:
		immuneTimer -= 1


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		isInFire = true


func _on_body_exited(_body):
	isInFire = false
	immuneTimer = 0
