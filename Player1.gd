extends CharacterBody2D

class_name Player1

var hasBall = false

var attack = true

@export var speed = 200

var screen_size

var target_clicked = position

@onready var target = $"../basketPoint"

@onready var ray = $"RayCast2D"

@onready var hasLineOfSight	= true;

signal passe(debut,fin)

func _ready():
	screen_size = get_viewport_rect().size
	
func _input(event):
	if event.is_action_pressed("click"):
		target_clicked = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target_clicked) * speed
	if position.distance_to(target_clicked) > 10:
		move_and_slide()

	else:
		velocity = Vector2.ZERO
		stop_moving_and_reset_animation()

	update_animation(velocity)
	if hasBall:
		if Input.is_action_pressed("espace"):
			passe.emit(position,ray.get_collider().position)
			hasBall = false
			print("Player 1 n'a plus la balle")

func stop_moving_and_reset_animation():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.stop()

func vector_to_screen_position(vector):
	return Vector2(vector.x * screen_size.x, vector.y * screen_size.y)

func update_animation(velocity):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		if hasBall:
			if velocity.x > 0 and velocity.x > abs(velocity.y):
				$AnimatedSprite2D.animation = "right_b"
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
				$AnimatedSprite2D.animation = "left_b"
			elif velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "up_b"
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "down_b"
		else:
			if velocity.x > 0 and velocity.x > abs(velocity.y):
				$AnimatedSprite2D.animation = "right"
			elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
				$AnimatedSprite2D.animation = "left"
			elif velocity.y < 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "up"
			elif velocity.y > 0 and abs(velocity.y) > abs(velocity.x):
				$AnimatedSprite2D.animation = "down"
	else:
		stop_moving_and_reset_animation()


func _on_ball_has_ball_player_1():
	hasBall = true
	print("Player 1 a la balle")
