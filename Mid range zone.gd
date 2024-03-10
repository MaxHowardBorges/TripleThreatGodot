extends Area2D

signal zoneMidPlayer1
signal zoneMidPlayer2
signal zoneMidEnemy1
signal zoneMidEnemy2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player1":
		zoneMidPlayer1.emit()
	elif body.name == "Player2":
		zoneMidPlayer2.emit()
	elif body.name == "Enemy":
		zoneMidEnemy1.emit()
	elif body.name == "Enemy2":
		zoneMidEnemy2.emit()
