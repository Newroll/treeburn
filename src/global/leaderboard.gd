extends Node2D

func _ready():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	var topScores = sw_result.scores
	var currentName
	var currentTime
	
	var i = topScores.size()
	var j = 0
	while i > 0:
		currentName = get_node(str(j+1)+"/name")
		currentTime = get_node(str(j+1)+"/time")
		currentName.set_text(topScores[j].player_name)
		currentTime.set_text(str(Main.time_convert(int(topScores[j].score*-1))))
		i -= 1
		j += 1
