extends CharacterBody2D

var talking = false

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


func _on_area_2d_body_exited(body):
	talking = false
