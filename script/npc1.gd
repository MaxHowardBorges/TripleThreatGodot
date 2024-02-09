extends CharacterBody2D

var talking = false
@onready var main_node = get_parent()
@onready var player_node = main_node.get_node("Player")
signal new_team_mate()

const lines: Array[String] = [
	"Bob : Yo !",
	"Ca joue ?",
	"Attend moi j'arrive"
]

func _on_area_2d_body_entered(body):
	if !talking:
		DialogManager.start_dialog(global_position, lines)
		talking = true
		new_team_mate.emit()
		player_node.team = player_node.team + 1


func _on_area_2d_body_exited(body):
	talking = false
