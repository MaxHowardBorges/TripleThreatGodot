extends CharacterBody2D

class_name Player1

@export var speed = 100

var screen_size

func player():
	pass

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		velocity.x +=1
	if Input.is_action_pressed('move_left'):
		velocity.x -=1
	if Input.is_action_pressed('move_up'):
		velocity.y -=1
	if Input.is_action_pressed('move_down'):
		velocity.y +=1

		
	position += velocity * 0.06
