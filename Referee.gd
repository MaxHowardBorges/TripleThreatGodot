extends CharacterBody2D

var whistle = false

func _physics_process(delta):
	if !whistle:
		$AnimatedSprite2D.play("idle")



func _on_idk_referee_whistle():
	whistle=true
	$AnimatedSprite2D.play("whistle")
	await get_tree().create_timer(1.50).timeout
	whistle=false
	
