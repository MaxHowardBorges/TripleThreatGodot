extends CharacterBody2D

class_name Player1

var hasBall = true

var attack = true

@export var speed = 50

var screen_size

@onready var target = $"../basketPoint"
@onready var ray = $"RayCast2D"
@onready var hasLineOfSight	= true;

@onready var current_line2D = Line2D.new()
var curve2d: Curve2D
var last_position : Vector2
var started = false


func _ready():
	screen_size = get_viewport_rect().size
	add_child(current_line2D)
	
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed('move_right'):
		velocity.x +=speed
	if Input.is_action_pressed('move_left'):
		velocity.x -=speed
	if Input.is_action_pressed('move_up'):
		velocity.y -=speed
	if Input.is_action_pressed('move_down'):
		velocity.y +=speed
	if Input.is_action_pressed("espace"):
		print("pass")

		
	position += velocity * 1

func _input(event):
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		started = true
		curve2d = null
		
		#prend dernière position
		if current_line2D.points.size() == 0 && last_position:
			current_line2D.add_point(last_position)
		#dessine les points
		if event is InputEventMouseButton:
			current_line2D.add_point(event.position)
	elif started:
		
		if !curve2d:
			curve2d = Curve2D.new()
			
			last_position = current_line2D.points[current_line2D.points.size()-1]
			
			for i in current_line2D.points.size():
				curve2d.add_point(current_line2D.points[i])
			
			$"../Path2D".curve = curve2d
			
			$"../Path2D/PathFollow2D".h_offset = 0
			$"../Path2D/PathFollow2D".v_offset = 0
			
			while $"../Path2D/PathFollow2D".h_offset < 1 && $"../Path2D/PathFollow2D".v_offset < 1:
				$"../Path2D/PathFollow2D".h_offset += speed
				$"../Path2D/PathFollow2D".v_offset += speed
				print($"../Path2D/PathFollow2D".h_offset)
#				position.x = $"../Path2D/PathFollow2D".h_offset
#				position.y = $"../Path2D/PathFollow2D".v_offset
#				var vec = Vector2(position.x, position.y)
#				print("x:", position.x)
#				print("y:", position.y)
#				print($"../Path2D/PathFollow2D".h_offset)
#				print("velocity", velocity)
#				velocity = position.direction_to(vec)*speed
#				move_and_slide()
			current_line2D.points = PackedVector2Array()
