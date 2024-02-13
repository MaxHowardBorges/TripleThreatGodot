extends CharacterBody2D

var isFree = true

signal hasBall

func _physics_process(delta): 
	if !isFree:
		#$Sprite2D.set_visible(false)
		$Area2D/CollisionShape2D.set_disabled(true)
		hasBall.emit()


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	isFree = false
	

func _on_player_1_passe(debut, fin):
	print(debut,fin)
	print(position)
	position = debut
	$Sprite2D.set_visible(true)
	$Sprite2D.show()
	print($Sprite2D.is_visible())
	$Area2D/CollisionShape2D.set_disabled(false)
	velocity = fin
	move_and_slide()
