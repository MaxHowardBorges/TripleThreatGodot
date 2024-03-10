extends CharacterBody2D


class_name Enemy2
var speed: float = 100

var zoneIn = ""
var zoneShoot = ""
var gameState = "defense"
var hasBall = false
signal passe(debut,fin)

@onready var main_node = get_parent()
@onready var ray = $"../basketPoint/RayCast2D"
@onready var player_node = main_node.get_node("Player2")
@onready var teammate = get_parent().get_node("Enemy")

func _physics_process(delta):
	var distance = (player_node.global_position - global_position).length()
	print(distance) 
	if gameState == "defense":
		if player_node == null: 
			pass
		if player_node != null && distance>150:
			velocity = position.direction_to(player_node.global_position)*speed
			move_and_slide()
		if player_node != null && distance<=150:
			pass
	if gameState == "offense" && hasBall:
			pass
	elif gameState == "offense" && !hasBall:
			pass
			#passe.emit(position,ray.get_collider().position)
			#hasBall = false
	


func _on_ball_has_ball_enemy_2():
	hasBall = true
	gameState = "offense"
	#if lastPlayedAnimation == "up" or lastPlayedAnimation == "idle_up":
	#	$AnimatedSprite2D.play("idle_b_up")
	#elif lastPlayedAnimation == "right" or lastPlayedAnimation == "idle_right":
	#	$AnimatedSprite2D.play("idle_b_right")
	#elif lastPlayedAnimation == "left" or lastPlayedAnimation == "idle_left":
	#	$AnimatedSprite2D.play("idle_b_left")
	#elif lastPlayedAnimation == "down" or lastPlayedAnimation == "idle_down":
	#	$AnimatedSprite2D.play("idle_b_down")
	print("Enemy 2 a la balle")
