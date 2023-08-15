extends Node2D


func _ready():
	var db_ref = Firebase.Database.get_database_reference("/time", {})
	print(db_ref)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
