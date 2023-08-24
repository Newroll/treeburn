extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Main.gameComplete = true
	var finalTime = Main.timeEclapsed*-1
	var sw_result = await SilentWolf.Scores.get_score_position(finalTime).sw_get_position_complete
	$loading.hide()
	var position = sw_result.position
	if position <= 10 && Main.leaderboardOffer == false:
		$highscorepopup.show()
	$highscorepopup/scorelabel.set_text("You attained a time of "+Main.time_convert(Main.timeEclapsed)+", placing you in "+Main.ordinal(position)+" place!")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Main.worldHealth = 3600


func _on_confirm_pressed():
	if $highscorepopup/nameinput.get_text().length() > 15:
		$highscorepopup/toolong.show()
	else:
		$HTTPRequest.request("https://www.purgomalum.com/service/containsprofanity?text="+$highscorepopup/nameinput.get_text())


func _on_leaderboard_pressed():
	get_tree().change_scene_to_file("res://src/global/leaderboard.tscn")
	Main.leaderboardOffer = true


func _on_cancel_pressed():
	$highscorepopup.hide()
	Main.leaderboardOffer = true


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://src/ui/intro.tscn")
	Main.leaderboardOffer = true

func _on_http_request_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	if json == true:
		$highscorepopup/warning.show()
	else:
		$loading.show()
		SilentWolf.Scores.save_score($highscorepopup/nameinput.get_text(), Main.timeEclapsed*-1)
		await get_tree().create_timer(3).timeout
		$loading.hide()
		$highscorepopup.hide()
		Main.leaderboardOffer = true
