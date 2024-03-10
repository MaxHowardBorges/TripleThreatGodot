extends Area2D

signal zoneOutsidePlayer1
signal zoneOutsidePlayer2
signal zoneOutsideEnemy1
signal zoneOutsideEnemy2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player1":
		zoneOutsidePlayer1.emit()
	elif body.name == "Player2":
		zoneOutsidePlayer2.emit()
	elif body.name == "Enemy":
		zoneOutsideEnemy1.emit()
	elif body.name == "Enemy2":
		zoneOutsideEnemy2.emit()
