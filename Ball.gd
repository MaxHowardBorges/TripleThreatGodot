extends CharacterBody2D

var isFree = true
@export var speed = 500
var lastOwner
var shooting = false
@onready var ray = $"../basketPoint/RayCast2D"
@onready var rebound1 = $"../Rebound1"
@onready var rebound2 = $"../Rebound2"
@onready var rebound3 = $"../Rebound3"
@onready var rebound4 = $"../Rebound4"

@onready var Success = $"../Success"
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
	if 	body != lastOwner and !shooting:
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

func _on_control_shoot_basket(debut, value):
	var distance_x = debut.distance_to(ray.global_position)
	var time_to_destination = distance_x / speed
	print("temsp",time_to_destination)
	position = debut
	
	shooting = true
	isFree = true
	velocity = position.direction_to(ray.global_position).normalized() * speed
	await get_tree().create_timer(time_to_destination).timeout
	velocity = Vector2.ZERO
	var rng = RandomNumberGenerator.new()
	var shot = rng.randi_range(0,100)
	if(shot<=value):
		print("CASH!")
		Success.show()
		await get_tree().create_timer(1.50).timeout
		get_tree().reload_current_scene()
	else:
		print("brick")
		var reb = rng.randi_range(1,4)
		var distance_z = 0
		if(reb==1):
			velocity = position.direction_to(rebound1.global_position).normalized() * speed
			distance_z = position.distance_to(rebound1.global_position)
		elif(reb==2):
			velocity = position.direction_to(rebound2.global_position).normalized() * speed
			distance_z = position.distance_to(rebound2.global_position)
		elif(reb==3):
			velocity = position.direction_to(rebound3.global_position).normalized() * speed
			distance_z = position.distance_to(rebound3.global_position)
		elif(reb==4):
			velocity = position.direction_to(rebound4.global_position).normalized() * speed
			distance_z = position.distance_to(rebound4.global_position)
		var time_to_rebound = distance_z / speed
		await get_tree().create_timer(time_to_rebound).timeout
		velocity = Vector2.ZERO
		print("temsp",time_to_destination)
		print(rebound1.position)
		lastOwner = null
	shooting = false


func _on_player_2_passe(debut, fin):
	position = debut
	isFree = true
	velocity = position.direction_to(fin).normalized() * speed
