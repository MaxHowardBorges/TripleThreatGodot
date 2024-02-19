extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()

func _on_timer_timeout():
	$TimeUp.show()
	$shotClock.hide()
	await get_tree().create_timer(1.50).timeout
	get_tree().reload_current_scene()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$shotClock.text = "%s" % roundf($Timer.time_left)
