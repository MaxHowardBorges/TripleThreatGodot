extends CharacterBody2D

@export var speed = 400
@onready var _animation_player = $AnimationPlayer
var target = position

func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

func _physics_process(delta):
	velocity = position.direction_to(target) * speed
	print(velocity)
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		velocity = Vector2.ZERO
		stop_moving_and_reset_animation()

	update_animation(velocity)

func stop_moving_and_reset_animation():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.stop()

func update_animation(velocity):
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()

		if velocity.x > 0 and velocity.x > abs(velocity.y):
			$AnimatedSprite2D.animation = "right"
		elif velocity.x < 0 and abs(velocity.x) > abs(velocity.y):
			$AnimatedSprite2D.animation = "left"
		elif velocity.y < 0:
			$AnimatedSprite2D.animation = "up"
		elif velocity.y > 0:
			$AnimatedSprite2D.animation = "down"
	else:
		stop_moving_and_reset_animation()

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
