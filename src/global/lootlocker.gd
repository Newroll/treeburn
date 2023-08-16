extends Node

# Use this game API key if you want to test it with a functioning leaderboard
# "987dbd0b9e5eb3749072acc47a210996eea9feb0"
var game_API_key = "dev_c65081249ded449895fead181300e23a"
var development_mode = true
var leaderboard_key = "time"
var session_token = ""
var score = 0
 
# HTTP Request node can only handle one call per node
var auth_http = HTTPRequest.new()
var leaderboard_http = HTTPRequest.new()
var submit_score_http = HTTPRequest.new()
var set_name_http = HTTPRequest.new()
var get_name_http = HTTPRequest.new()

var leaderboard = {}
 
func _ready():
	_authentication_request()
	_get_leaderboards()
 
 
func _process(_delta):
#	if(Input.is_action_just_pressed("ui_up")):
#		score += 1
#		print("CurrentScore:"+str(score))
#
#	if(Input.is_action_just_pressed("ui_down")):
#		score -= 1
#		print("CurrentScore:"+str(score))
 
	# Upload score when pressing enter
	if(Input.is_action_just_pressed("ui_accept")):
		_change_player_name("helloo")
		_upload_score(score)
 
	# Get score when pressing spacebar
	if(Input.is_action_just_pressed("ui_select")):
		_get_leaderboards()
 
 
 
func _authentication_request():
	var player_identifier : String
	# Check if a player session has been saved
	var player_session_exists = false
	var file = FileAccess.open("user://LootLocker.data", FileAccess.READ)
	if file != null:
		player_identifier = file.get_as_text()
		print("played ID="+player_identifier)
		file.close()
 
	if player_identifier != null and player_identifier.length() > 1:
		print("player session exists, id="+player_identifier)
		player_session_exists = true
 
	## Convert data to json string:
	var data = { "game_key": game_API_key, "game_version": "0.0.0.1", "development_mode": true }
 
	# If a player session already exists, send with the player identifier
	if(player_session_exists == true):
		data = { "game_key": game_API_key, "player_identifier":player_identifier, "game_version": "0.0.0.1", "development_mode": true }
 
	# Add 'Content-Type' header:
	var headers = ["Content-Type: application/json"]
 
	# Create a HTTPRequest node for authentication
	auth_http = HTTPRequest.new()
	add_child(auth_http)
	auth_http.request_completed.connect(_on_authentication_request_completed)
 
	# Print what we're sending, for debugging purposes:
	#print(data)
 
	auth_http.request("https://api.lootlocker.io/game/v2/session/guest", headers, HTTPClient.METHOD_POST, JSON.stringify(data))
 
 
func _on_authentication_request_completed(result, response_code, headers, body):
	var authJson = JSON.parse_string(body.get_string_from_utf8())
#	print(authJson)
 
	# Save player_identifier to file
	var file = FileAccess.open("user://LootLocker.data", FileAccess.WRITE)
	if file != null:
		print("file open for writing")
		if authJson.has("player_identifier"):
			print("store played id")
			file.store_string(authJson["player_identifier"])
			file.close()
 
			# Save session_token to memory
			print("session token="+authJson["session_token"])
			session_token = authJson["session_token"]
		else:
			if authJson.has("error"):
				print("Error: "+authJson["error"])
 
 
	# Clear node
	auth_http.queue_free()
	# Get leaderboards
	_get_leaderboards()
 
 
func _get_leaderboards():
	print("Getting leaderboards")
	var url = "https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/list?count=10"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
 
	# Create a request node for getting the highscore
	leaderboard_http = HTTPRequest.new()
	add_child(leaderboard_http)
	leaderboard_http.request_completed.connect(_on_leaderboard_request_completed)
	# Send request
	leaderboard_http.request(url, headers, HTTPClient.METHOD_GET, "")
	
 
func _on_leaderboard_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	leaderboard = json
#	print(json)
#	return (json)
#	if json.has("error"):
#		print("Error: "+json["error"])
#	else:
#		# Formatting as a leaderboard
#		var leaderboardFormatted = ""
#		for n in json["items"].size():
#			leaderboardFormatted += str(json["items"][n].rank)+str(". ")
#			leaderboardFormatted += str(json["items"][n].player.id)+str(" - ")
#			leaderboardFormatted += str(json["items"][n].score)
#			if json["items"][n].metadata != null:
#				print("add meta:"+json["items"][n].metadata)
#				leaderboardFormatted += str(" - ")+json["items"][n].metadata
#			leaderboardFormatted += str("\n")
 
		# Print the formatted leaderboard to the console
#		print(leaderboardFormatted)
 
		# Clear node
#		leaderboard_http.queue_free()
 
func _upload_score(score: int):
	var data = { "score": str(score) }
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	submit_score_http = HTTPRequest.new()
	add_child(submit_score_http)
	submit_score_http.request_completed.connect(_on_upload_score_request_completed)
 
	# Print what we're sending, for debugging purposes:
	print(data)
 
	submit_score_http.request("https://api.lootlocker.io/game/leaderboards/"+leaderboard_key+"/submit", headers, HTTPClient.METHOD_POST, JSON.stringify(data))
 
func _change_player_name(newName):
	print("Changing player name")
	
	# use this variable for setting the name of the player
	var player_name = newName
	
	var data = { "name": str(player_name) }
	var url =  "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	# Send request
	set_name_http = HTTPRequest.new()
	add_child(set_name_http)
	set_name_http.request_completed.connect(_on_player_set_name_request_completed)
	set_name_http.request(url, headers, HTTPClient.METHOD_PATCH, JSON.stringify(data))
	
func _on_player_set_name_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	
	# Print data
	print(json)
	set_name_http.queue_free()

func _get_player_name():
	print("Getting player name")
	var url = "https://api.lootlocker.io/game/player/name"
	var headers = ["Content-Type: application/json", "x-session-token:"+session_token]
	
	# Create a request node for getting the highscore
	get_name_http = HTTPRequest.new()
	add_child(get_name_http)
	get_name_http.request_completed.connect(_on_player_get_name_request_completed)
	# Send request
	get_name_http.request(url, headers, HTTPClient.METHOD_GET, "")
	
func _on_player_get_name_request_completed(result, response_code, headers, body):
	var playerName = JSON.parse_string(body.get_string_from_utf8())
	
	# Print data
	print(playerName)

func _on_upload_score_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
 
	# Print data
	print("upload score result:"+str(json))
 
	# Clear node
	submit_score_http.queue_free()
