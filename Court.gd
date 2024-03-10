extends Node2D

var teamAttack = "home"

signal homeGoAttack
signal homeGoDefense
signal awayGoAttack
signal awayGoDefense
signal resetBall

func _ready():
	$Timer.start()

func _on_timer_timeout():
	$TimeUp.show()
	$shotClock.hide()
	$Player1.hasBall = false
	$Player2.hasBall = false
	$Enemy.hasBall = false
	$Enemy2.hasBall = false
	await get_tree().create_timer(1.50).timeout
	#get_tree().reload_current_scene()
	if teamAttack == "home":
		homeGoDefense.emit()
		awayGoAttack.emit()
		teamAttack = "away"
		resetBall.emit()
		$Enemy.gameState = "attack"
	else:
		homeGoAttack.emit()
		awayGoDefense.emit()
		teamAttack = "home"
		resetBall.emit()
	$Timer.start()
	$TimeUp.hide()
	$shotClock.show()
	
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
		$Success.show()
		await get_tree().create_timer(1.50).timeout
		score = $scoreHome.text
		scoreInt = int(score)
		if zoneIn == "Perimiter" or zoneIn == "Outside":
			scoreInt += 3
		else:
			scoreInt += 2
		scoreStr = str(scoreInt)
		$scoreHome.text = scoreStr
		homeGoDefense.emit()
		awayGoAttack.emit()
		$Enemy.gameState = "attack"
		$Enemy2.gameState = "attack"
		$Success.hide()
		await get_tree().create_timer(0.50).timeout
		resetBall.emit()
		$Timer.start()
		teamAttack = "away"
		
	elif team == "away":
		$Success.show()
		await get_tree().create_timer(1.50).timeout
		score = $scoreAway.text
		scoreInt = int(score)
		if zoneIn == "Perimiter" or zoneIn == "Outside":
			scoreInt += 3
		else:
			scoreInt += 2
		scoreStr = str(scoreInt)
		$scoreAway.text = scoreStr
		homeGoAttack.emit()
		awayGoDefense.emit()
		$Success.hide()
		await get_tree().create_timer(0.50).timeout
		resetBall.emit()
		$Timer.start()
		teamAttack = "home"
		
func _on_player_1_team_ball(team):
	if team != teamAttack:
		$Timer.start()
		teamAttack = team
		$Enemy.gameState = "defense"
		$Enemy2.gameState = "defense"
		print("test")
		
func _on_player_2_team_ball(team):
	if team != teamAttack:
		$Timer.start()
		teamAttack = team
		$Enemy.gameState = "defense"
		$Enemy2.gameState = "defense"
