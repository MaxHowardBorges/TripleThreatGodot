extends CollisionShape2D


signal zoneEnterRightPlayer1

signal zoneEnterRightPlayer2

signal zoneExitRightPlayer1

signal zoneExitRightPlayer2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_right_zone_body_entered(body):
	if body.name == "Player1":
		zoneEnterRightPlayer1.emit()
	elif body.name == "Player2":
		zoneEnterRightPlayer2.emit()


func _on_right_zone_body_exited(body):
	if body.name == "Player1":
		zoneExitRightPlayer1.emit()
	elif body.name == "Player2":
		zoneExitRightPlayer2.emit()
