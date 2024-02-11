extends CharacterBody2D


class_name Enemy
var speed: float = 0

@onready var main_node = get_parent()
@onready var player_node = main_node.get_node("Player1")

func _physics_process(delta): 
	if player_node == null: 
		pass
	if player_node != null:
		velocity = position.direction_to(player_node.global_position)*speed
		
		move_and_slide()
