extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

func _on_timer_timeout():
	$TimeUp.show()
	$shotClock.hide()
	await get_tree().create_timer(1.50).timeout
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $scoreAway.text == "21" or $scoreAway.text == "22" or $scoreAway.text == "23":
		print("Away win")
		get_tree().reload_current_scene()
	if $scoreHome.text == "21" or $scoreHome.text == "22" or $scoreHome.text == "23":
		print("Home win")
		get_tree().reload_current_scene()
	$shotClock.text = "%s" % roundf($Timer.time_left)


func _on_ball_score(team, zoneIn):
	var score
	var scoreInt
	var scoreStr
	if team == "home":
		score = $scoreHome.text
		scoreInt = int(score)
		if zoneIn == "Perimiter" or zoneIn == "Outside":
			scoreInt += 3
		else:
			scoreInt += 2
		scoreStr = str(scoreInt)
		$scoreHome.text = scoreStr
	elif team == "away":
		score = $scoreAway.text
		scoreInt = int(score)
		if zoneIn == "Perimiter" or zoneIn == "Outside":
			scoreInt += 3
		else:
			scoreInt += 2
		scoreStr = str(scoreInt)
		$scoreAway.text = scoreStr
