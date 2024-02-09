extends CharacterBody2D

class_name Player1

var hasBall = false

var attack = true

@export var speed = 5

var screen_size

@onready var target = $"../basketPoint"

@onready var ray = $"RayCast2D"

@onready var hasLineOfSight	= true;

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		velocity.x +=speed
	if Input.is_action_pressed('move_left'):
		velocity.x -=speed
	if Input.is_action_pressed('move_up'):
		velocity.y -=speed
	if Input.is_action_pressed('move_down'):
		velocity.y +=speed

		
	position += velocity * 1
