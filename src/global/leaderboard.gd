extends Node2D

func _ready():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	$loading.hide()
	var topScores = sw_result.scores
	var currentName
	var currentTime
	
	var i = topScores.size()
	var j = 0
	while i > 0:
		currentName = get_node("BoxContainer/ColorRect/contentContainer/positionContainer/VBoxContainer/"+str(j+1)+"/name")
		currentTime = get_node("BoxContainer/ColorRect/contentContainer/positionContainer/VBoxContainer/"+str(j+1)+"/time")
		currentName.set_text(topScores[j].player_name)
		currentTime.set_text(str(Main.time_convert(int(topScores[j].score*-1))))
		i -= 1
		j += 1


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://src/ui/intro.tscn")
