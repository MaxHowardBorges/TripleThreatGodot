extends CharacterBody2D

var talking = true
var finished_talking = false
@onready var main_node = get_parent()
@onready var player_node = main_node.get_node("Player")
var is_talking = false


const lines: Array[String] = [
	"Lucas : Wesh !",
	"Allons jouer au basket !",
	"J'ai passé ma soirée sur courtview !"
]

func _on_area_2d_body_entered(body):
	is_talking = player_node.talking
	if !talking && !finished_talking && !is_talking:
		player_node.talking = true
		DialogManager.start_dialog(global_position, lines)
		talking = true
		player_node.team = player_node.team + 1
		finished_talking = true
		
	else:
		talking = false


func _on_area_2d_body_exited(body):
	talking = false
	player_node.talking = false
