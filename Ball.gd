extends CharacterBody2D

var isFree = true
@export var speed = 500
var lastOwner

@onready var ray = $"../basketPoint/RayCast2D"
signal hasBallPlayer1
signal hasBallPlayer2

func _physics_process(delta): 
	if !isFree:
		$AnimatedSprite2D.set_visible(false)
		$Area2D/CollisionShape2D.set_disabled(true)
	else:
		$AnimatedSprite2D.set_visible(true)
		$Area2D/CollisionShape2D.set_disabled(false)
	move_and_slide()
	$AnimatedSprite2D.play("move")
func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if 	body != lastOwner:
		isFree = false
		lastOwner = body
		if body.name == "Player1":
			hasBallPlayer1.emit()
		elif body.name == "Player2":
			hasBallPlayer2.emit()

func _on_player_1_passe(debut, fin):
	
	position = debut
	isFree = true
	velocity = position.direction_to(fin).normalized() * speed

func _on_control_shoot_basket(debut):
	position = debut
	isFree = true
	velocity = position.direction_to(ray.global_position).normalized() * speed
