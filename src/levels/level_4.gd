extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Main.gameComplete = true
	var finalTime = Main.timeEclapsed - Main.timeEclapsed*2
	var sw_result = await SilentWolf.Scores.get_score_position(finalTime).sw_get_position_complete
	var position = sw_result.position
	if position <= 10:
		$highscorepopup.show()
	$highscorepopup/scorelabel.set_text("You attained a time of "+Main.time_convert(finalTime)+", placing you in "+Main.ordinal(position)+" place!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Main.worldHealth = 3600


func _on_confirm_pressed(finalTime):
	if BadWordsFilter.is_word_ok($highscorepopup/nameinput.get_text()) == false:
		$highscorepopup/warning.show()
	else:
		SilentWolf.Scores.save_score($highscorepopup/nameinput.get_text(), finalTime)
		$highscorepopup.hide()


func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://src/global/leaderboard.tscn")


func _on_cancel_pressed():
	$highscorepopup.hide()
