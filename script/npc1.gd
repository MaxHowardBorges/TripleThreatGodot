extends CharacterBody2D

var talking = false

const lines: Array[String] = [
	"Bob : Yo !",
	"Ca joue ?",
	"Attend moi j'arrive"
]

#func _unhandled_input(event):
#	if event.is_action_pressed("click"):
#		DialogManager.start_dialog(global_position, lines)


#func _input(event):
	#if event.is_action_pressed("adc"):

		#if get_viewport_rect().has_point(to_local(event.position)):

			#DialogManager.start_dialog(global_position, lines)



func _on_area_2d_body_entered(body):
	if !talking:
		DialogManager.start_dialog(global_position, lines)
		talking = true


func _on_area_2d_body_exited(body):
	talking = false
