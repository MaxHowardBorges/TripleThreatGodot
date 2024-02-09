extends CharacterBody2D


class_name Enemy
var speed: float = 100.0

@onready var target = $"../Player1"

func _physics_process(delta):
	if target == null: get_parent().get_node("Player1")
	if target != null:
		velocity = position.direction_to(target.position)*speed
		move_and_slide()
