extends Area2D

signal zonePaintPlayer1
signal zonePaintPlayer2
signal zonePaintEnemy1
signal zonePaintEnemy2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	if body.name == "Player1":
		zonePaintPlayer1.emit()
	elif body.name == "Player2":
		zonePaintPlayer2.emit()
	elif body.name == "Enemy":
		zonePaintEnemy1.emit()
	elif body.name == "Enemy2":
		zonePaintEnemy2.emit()
