extends Node

var character_scene = load("res://src/interactive/blocker.tscn")

func _ready():
	
	var node = character_scene.instantiate()
	node.position = Vector2(693, -447)
	add_child(node)
