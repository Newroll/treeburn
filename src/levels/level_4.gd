extends Node2D

var time = Main.timeEclapsed
var leaderboardLength = 10
var scoreArr = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	# DELETE THIS AWAIT
	await get_tree().create_timer(5).timeout
	
	var leaderboard = Lootlocker.leaderboard.items
	
	if leaderboard.size() < 10:
		leaderboardLength = leaderboard.size()
	
	var i: int = leaderboardLength - 1
	while i >= 0:
		print(leaderboard[i].get("score"))
		scoreArr.append(leaderboard[i].get("score"))
		i -= 1
	print(scoreArr)
	print(leaderboard)
	
	var array = [1, 3, 5, 7, 9]
	var value = 5
	var function_to_compare = func(a, b): return a < b
	var index = array.bsearch_custom(value, function_to_compare)
	print(index) # Prints 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
