extends CharacterBody2D


class_name Enemy
var speed: float = 200

var zoneIn = ""
var zoneShoot = ""
var lastPlayedAnimation = "idle_down"
@export var gameState = "defense"
@export var hasBall = false
@onready var spawnAttack = $"../SpawnAttack1"
@onready var spawnDefense = $"../SpawnDefense1"
@onready var checkpoint1 = $"../Checkpoint1"
signal passe(debut,fin)
signal teamAttack()
signal shoot(debut)
@onready var main_node = get_parent()
@onready var ray = $"RayCast2Denemy1"
@onready var player_node = main_node.get_node("Player1")
@onready var teammate = $"../Enemy"

func _ready():
	$AnimatedSprite2D.play("idle_down")

func _physics_process(	delta):
	var distance = (player_node.global_position - global_position).length()
	update_animation(velocity)
	if gameState == "defense":
		if player_node == null: 
			pass
		if player_node != null && distance>120:
			velocity = position.direction_to(player_node.global_position)*speed
			move_and_slide()
		elif player_node != null && distance<120:
			velocity = Vector2.ZERO
	#1st scenario
	if gameState == "attack" && hasBall:
			velocity = position.direction_to(checkpoint1.global_position)*speed
			#move_and_slide()
			velocity = Vector2.ZERO
			await get_tree().create_timer(0.75).timeout
			passe.emit(position,ray.get_collider().position)
			hasBall = false
	#2nd
	elif gameState == "attack" && !hasBall:
			pass
			#passe.emit(position,ray.get_collider().position)
			#hasBall = false
func update_animation(velocity):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		if hasBall:
			if velocity.x > 0 and velocity.x > abs(velocity.y):
				$AnimatedSprite2D.animation = "right_b"
				lastPlayedAnimation = "right_b"
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
				$AnimatedSprite2D.animation = "left_b"
				lastPlayedAnimation = "left_b"
			elif velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "up_b"
				lastPlayedAnimation = "up_b"
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "down_b"
				lastPlayedAnimation = "down_b"
		else:
			if velocity.x > 0 and velocity.x > abs(velocity.y):
				$AnimatedSprite2D.animation = "right"
				lastPlayedAnimation = "right"
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
				$AnimatedSprite2D.animation = "left"
				lastPlayedAnimation = "left"
			elif velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "up"
				lastPlayedAnimation = "up"
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "down"
				lastPlayedAnimation = "down"
	else:
		#stop_moving_and_reset_animation()
		if hasBall:
			if lastPlayedAnimation == "up_b":
				$AnimatedSprite2D.animation = "idle_b_up"
			elif lastPlayedAnimation == "right_b":
				$AnimatedSprite2D.animation = "idle_b_right"
			elif lastPlayedAnimation == "left_b":
				$AnimatedSprite2D.animation = "idle_b_left"
			elif lastPlayedAnimation == "down_b":
				$AnimatedSprite2D.animation = "idle_b_down"
		else:
			if lastPlayedAnimation == "up":
				$AnimatedSprite2D.animation = "idle_up"
			elif lastPlayedAnimation == "right":
				$AnimatedSprite2D.animation = "idle_right"
			elif lastPlayedAnimation == "left":
				$AnimatedSprite2D.animation = "idle_left"
			elif lastPlayedAnimation == "down":
				$AnimatedSprite2D.animation = "idle_down"

func _on_ball_has_ball_enemy():
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
	print("Enemy a la balle")


func _on_idk_away_go_attack():
	position = spawnAttack.position


func _on_idk_away_go_defense():
	position = spawnDefense.position


func _on_paint_zone_zone_paint_enemy_1():
	zoneIn = "Paint"


func _on_mid_range_zone_zone_mid_enemy_1():
	zoneIn = "Mid"


func _on_perimeter_zone_zone_perimeter_enemy_1():
	zoneIn = "Perimiter"


func _on_outside_zone_zone_outside_enemy_1():
	zoneIn = "Outside"


func _on_enemy_2_team_attack():
	gameState = "attack"
