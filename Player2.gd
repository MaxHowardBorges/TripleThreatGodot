extends CharacterBody2D

class_name Player2

var hasBall = false

var attack = true

@export var speed =200

var screen_size

var target_clicked = position

@onready var target = $"../basketPoint"

@onready var ray = $"RayCast2D"

@onready var hasLineOfSight	= true;

func _ready():
	screen_size = get_viewport_rect().size

func _on_ball_has_ball():
	hasBall = true
	print("ZZZZZZZZZZ")
