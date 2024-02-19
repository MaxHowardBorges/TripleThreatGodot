extends Control


@onready var ShootBar = $ShootBar
var shoot = false
var increasing: bool = true
var progressSpeed: float = 100.0
var clr1 = "#FE0802"
var clr2 = "#F93F15"
var clr3 = "#F57628"
var clr4 = "#F0AB3A"
var clr5 = "#ECE04C"
var clr6 = "#DEF753"
var clr7 = "#C9F852"
var clr8 = "#B2F951"
var clr9 = "#9DFA51"
var clr10 = "#86FB50"

func _ready():
		ShootBar.hide()
	
func _process(delta):
	if shoot == true:
		if increasing:
			ShootBar.value += get_process_delta_time() * progressSpeed
		else:
			ShootBar.value -= get_process_delta_time() * progressSpeed
		if ShootBar.value >= 100.0:
			ShootBar.value = 100.0
			increasing = false
		elif ShootBar.value <= 0.0:
			ShootBar.value = 0.0
			increasing = true
		
		if ShootBar.value > 90.0 and ShootBar.value <= 100.0:
			ShootBar.set_tint_progress(clr10)
		elif ShootBar.value >= 80.0 and ShootBar.value < 90.0:
			ShootBar.set_tint_progress(clr9)
		elif ShootBar.value >= 70.0 and ShootBar.value < 80.0:
			ShootBar.set_tint_progress(clr8)
		elif ShootBar.value >= 60.0 and ShootBar.value < 70.0:
			ShootBar.set_tint_progress(clr7)
		elif ShootBar.value >= 50.0 and ShootBar.value < 60.0:
			ShootBar.set_tint_progress(clr6)
		elif ShootBar.value >= 40.0 and ShootBar.value < 50.0:
			ShootBar.set_tint_progress(clr5)
		elif ShootBar.value >= 30.0 and ShootBar.value < 40.0:
			ShootBar.set_tint_progress(clr4)
		elif ShootBar.value >= 20.0 and ShootBar.value < 30.0:
			ShootBar.set_tint_progress(clr3)
		elif ShootBar.value >= 10.0 and ShootBar.value < 20.0:
			ShootBar.set_tint_progress(clr2)
		elif ShootBar.value >= 0.0 and ShootBar.value < 10.0:
			ShootBar.set_tint_progress(clr1)

func _on_player_1_shoot_pressed():
	print("pressed")
	ShootBar.show()
	shoot = true
	
func _on_player_1_shoot_released():
	print("released")
	print("shoot value : ", ShootBar.value)
	ShootBar.hide()
	shoot = false
	ShootBar.value = 0.0
