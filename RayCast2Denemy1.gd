extends RayCast2D

var nbr = 0

@onready var teammate = get_parent().get_parent().get_node("Enemy2")

var basket = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(teammate.global_position)
	if is_colliding():
		#print("green")
		#print(nbr)
		nbr=nbr+1