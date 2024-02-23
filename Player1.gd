extends CharacterBody2D

class_name Player1

var hasBall = false
var attack = true
var shooting = false
@export var speed = 200
var screen_size
var target_clicked = position
var key_states = {}
var lastPlayedAnimation = ""
@onready var target = $"../basketPoint"
@onready var ray = $"RayCast2D"
@onready var shootBar = $"../Control/ShootBar"
@onready var hasLineOfSight	= true;

signal passe(debut,fin)
signal shootPressed
signal shootReleased(debut)

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.animation = "idle_down"
	
func _input(event):
	if event.is_action_pressed("click"):
		target_clicked = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target_clicked) * speed
	if position.distance_to(target_clicked) > 10 and !shooting:
		move_and_slide()

	else:
		velocity = Vector2.ZERO
		#stop_moving_and_reset_animation()
	print(hasBall)
	update_animation(velocity)
	if hasBall:
		if Input.is_action_pressed("espace") && !shooting:
			passe.emit(position,ray.get_collider().position)
			hasBall = false
			print("Player 1 n'a plus la balle")
		if Input.is_action_pressed("shoot"):
			if not key_states.has("shoot") or not key_states["shoot"]:
				key_states["shoot"] = true
				shootPressed.emit()
				shooting = true
				velocity = Vector2.ZERO
		elif key_states.has("shoot") and key_states["shoot"]:
			velocity = Vector2.ZERO
			key_states["shoot"] = false
			shootReleased.emit(position)
			shooting = false
			hasBall = false
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
		else:
			if lastPlayedAnimation == "up":
				$AnimatedSprite2D.animation = "idle_up"
			elif lastPlayedAnimation == "right":
				$AnimatedSprite2D.animation = "idle_right"
			elif lastPlayedAnimation == "left":
				$AnimatedSprite2D.animation = "idle_left"
			elif lastPlayedAnimation == "down":
				$AnimatedSprite2D.animation = "idle_down"

func _on_ball_has_ball_player_1():
	hasBall = true
	print("Player 1 a la balle")
