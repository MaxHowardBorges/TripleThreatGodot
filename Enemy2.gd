extends CharacterBody2D


class_name Enemy2
var speed: float = 200

var zoneIn = ""
var zoneShoot = ""
var gameState = "defense"
@export var hasBall = false
@onready var spawnAttack = $"../SpawnAttack2"
@onready var spawnDefense = $"../SpawnDefense2"
@onready var checkpoint1 = $"../Rebound1"
signal passe(debut,fin)
signal teamAttack()
signal shoot(debut)
@onready var main_node = get_parent()
@onready var ray = $"../basketPoint/RayCast2D"
@onready var player_node = main_node.get_node("Player2")
@onready var teammate = get_parent().get_node("Enemy")

func _physics_process(delta):
	var distance = (player_node.global_position - global_position).length()
	if gameState == "defense":
		if player_node == null: 
			pass
		if player_node != null && distance>150:
			velocity = position.direction_to(player_node.global_position)*speed
			move_and_slide()
		if player_node != null && distance<=150:
			pass
	if gameState == "attack" && hasBall:
		velocity = Vector2.ZERO
		shoot.emit(global_position)
		hasBall = false
	elif gameState == "attack" && !hasBall:
		velocity = Vector2.ZERO
		velocity = position.direction_to(checkpoint1.global_position)*speed
		move_and_slide()
	

func _on_ball_has_ball_enemy_2():
	hasBall = true
	gameState = "attack"
	#if lastPlayedAnimation == "up" or lastPlayedAnimation == "idle_up":
	#	$AnimatedSprite2D.play("idle_b_up")
	#elif lastPlayedAnimation == "right" or lastPlayedAnimation == "idle_right":
	#	$AnimatedSprite2D.play("idle_b_right")
	#elif lastPlayedAnimation == "left" or lastPlayedAnimation == "idle_left":
	#	$AnimatedSprite2D.play("idle_b_left")
	#elif lastPlayedAnimation == "down" or lastPlayedAnimation == "idle_down":
	#	$AnimatedSprite2D.play("idle_b_down")
	print("Enemy 2 a la balle")


func _on_idk_away_go_attack():
	position = spawnAttack.position


func _on_idk_away_go_defense():
	position = spawnDefense.position


func _on_paint_zone_zone_paint_enemy_2():
	zoneIn = "Paint"


func _on_mid_range_zone_zone_mid_enemy_2():
	zoneIn = "Mid"

func _on_perimeter_zone_zone_perimeter_enemy_2():
	zoneIn = "Perimiter"


func _on_outside_zone_zone_outside_enemy_2():
	zoneIn = "Outside"


func _on_enemy_team_attack():
	gameState = "attack"
