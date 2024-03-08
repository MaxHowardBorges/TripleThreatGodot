extends CollisionShape2D

signal zoneEnterLeftPlayer1

signal zoneEnterLeftPlayer2

signal zoneExitLeftPlayer1

signal zoneExitLeftPlayer2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_left_zone_body_entered(body):
	if body.name == "Player1":
		zoneEnterLeftPlayer1.emit()
	elif body.name == "Player2":
		zoneEnterLeftPlayer2.emit()

func _on_left_zone_body_exited(body):
	if body.name == "Player1":
		zoneExitLeftPlayer1.emit()
	elif body.name == "Player2":
		zoneExitLeftPlayer2.emit()
