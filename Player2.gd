extends CharacterBody2D

class_name Player2

var Playing = false
var hasBall = false
var attack = true
var shooting = false
@export var speed = 200
var screen_size
var target_clicked = position
var key_states = {}
var lastPlayedAnimation = "idle_down"
var zoneIn = ""
var zoneShoot = ""
@onready var target = $"../basketPoint"
@onready var ray = $"RayCast2Dbis"
@onready var shootBar = $"../Control/ShootBar"
@onready var spawnAttack = $"../SpawnAttack2"
@onready var spawnDefense = $"../SpawnDefense2"
@onready var hasLineOfSight	= true;

signal passe(debut,fin)
signal shootPressed()
signal shootReleased(debut,zoneIn)

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle_down")
	
func _input(event):
	if event.is_action_pressed("click") and Playing:
		target_clicked = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target_clicked) * speed
	if position.distance_to(target_clicked) > 10 and !shooting and Playing:
		move_and_slide()

	else:
		velocity = Vector2.ZERO
		#stop_moving_and_reset_animation()
	update_animation(velocity)
	if hasBall and Playing:
		if Input.is_action_pressed("espace") && !shooting:
			passe.emit(position,ray.get_collider().position)
			hasBall = false
			Playing = false
			if lastPlayedAnimation == "up_b" or lastPlayedAnimation == "idle_b_up":
				$AnimatedSprite2D.play("idle_up")
			elif lastPlayedAnimation == "right_b" or lastPlayedAnimation == "idle_b_right":
				$AnimatedSprite2D.play("idle_right")
			elif lastPlayedAnimation == "left_b" or lastPlayedAnimation == "idle_b_left":
				$AnimatedSprite2D.play("idle_left")
			elif lastPlayedAnimation == "down_b" or lastPlayedAnimation == "idle_b_down":
				$AnimatedSprite2D.play("idle_down")
		if Input.is_action_pressed("shoot"):
			if not key_states.has("shoot") or not key_states["shoot"]:
				key_states["shoot"] = true
				shootPressed.emit()
				shooting = true
				velocity = Vector2.ZERO
		elif key_states.has("shoot") and key_states["shoot"]:
			velocity = Vector2.ZERO
			key_states["shoot"] = false
			shootReleased.emit(position, zoneIn)
			shooting = false
			hasBall = false
			if zoneShoot == "left":
				$AnimatedSprite2D.animation = "shoot_right"
			elif zoneShoot == "right":
				$AnimatedSprite2D.animation = "shoot_left"
			else:
				$AnimatedSprite2D.animation = "shoot_up"
				lastPlayedAnimation = "shoot_up"


func stop_moving_and_reset_animation():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.stop()

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
				lastPlayedAnimation = "idle_b_down"
		else:
			if lastPlayedAnimation == "up":
				$AnimatedSprite2D.animation = "idle_up"
			elif lastPlayedAnimation == "right":
				$AnimatedSprite2D.animation = "idle_right"
			elif lastPlayedAnimation == "left":
				$AnimatedSprite2D.animation = "idle_left"
			elif lastPlayedAnimation == "down":
				$AnimatedSprite2D.animation = "idle_down"

func _on_ball_has_ball_player_2():
	hasBall = true
	Playing = true
	if lastPlayedAnimation == "up" or lastPlayedAnimation == "idle_up":
		$AnimatedSprite2D.play("idle_b_up")
	elif lastPlayedAnimation == "right" or lastPlayedAnimation == "idle_right":
		$AnimatedSprite2D.play("idle_b_right")
	elif lastPlayedAnimation == "left" or lastPlayedAnimation == "idle_left":
		$AnimatedSprite2D.play("idle_b_left")
	elif lastPlayedAnimation == "down" or lastPlayedAnimation == "idle_down":
		$AnimatedSprite2D.play("idle_b_down")

func _on_perimeter_zone_zone_perimeter_player_2():
	zoneIn = "Perimeter"

func _on_outside_zone_zone_outside_player_2():
	zoneIn = "Outside"

func _on_mid_range_zone_zone_mid_player_2():
	zoneIn = "Mid"

func _on_paint_zone_zone_paint_player_2():
	zoneIn = "Paint"

func _on_left_shoot_zone_enter_left_player_2():
	zoneShoot = "left"

func _on_left_shoot_zone_exit_left_player_2():
	zoneShoot = ""

func _on_right_shoot_zone_enter_right_player_2():
	zoneShoot = "right"

func _on_right_shoot_zone_exit_right_player_2():
	zoneShoot = ""

func _on_idk_home_go_attack():
	position = spawnAttack.position

func _on_idk_home_go_defense():
	velocity = Vector2.ZERO
	global_position = spawnDefense.global_position
	
