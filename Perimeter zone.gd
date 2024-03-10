extends Area2D

signal zonePerimeterPlayer1
signal zonePerimeterPlayer2
signal zonePerimeterEnemy1
signal zonePerimeterEnemy2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player1":
		zonePerimeterPlayer1.emit()
	elif body.name == "Player2":
		zonePerimeterPlayer2.emit()
	elif body.name == "Enemy":
		zonePerimeterEnemy1.emit()
	elif body.name == "Enemy2":
		zonePerimeterEnemy2.emit()
