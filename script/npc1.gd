extends CharacterBody2D


const lines: Array[String] = [
	"Bob : Yo !",
	"Ca joue ?",
	"Attend moi j'arrive"
]

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		DialogManager.start_dialog(global_position, lines)
