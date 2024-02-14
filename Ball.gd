extends CharacterBody2D

var isFree = true
@export var speed = 500
var free_time = 3
var elapsed_time = 0.0
var lastOwner
signal hasBall

func _physics_process(delta): 
	if !isFree:
		$Sprite2D.set_visible(false)
		$Area2D/CollisionShape2D.set_disabled(true)
		hasBall.emit()
	else:
		$Sprite2D.set_visible(true)
		$Area2D/CollisionShape2D.set_disabled(false)
	move_and_slide()

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if 	body != lastOwner:
		isFree = false
		lastOwner = body
	else:
		pass

func _on_player_1_passe(debut, fin):
	position = debut
	isFree = true
	velocity = position.direction_to(fin).normalized() * speed
