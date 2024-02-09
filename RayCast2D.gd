extends RayCast2D

var nbr = 0

@onready var basket_node = get_parent().get_parent().get_node("Player1")

var basket = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(basket_node.global_position)
	if is_colliding():
		#print("Colliding")
		#print(nbr)
		nbr=nbr+1

func _draw():
		draw_line(basket, target_position, Color(1, 0, 0), 10)

