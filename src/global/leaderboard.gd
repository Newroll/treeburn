extends Node2D

func _ready():
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	var topScores = Array.reverse(sw_result.scores)
