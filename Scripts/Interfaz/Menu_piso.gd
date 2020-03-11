extends KinematicBody2D

var motion = Vector2()
var velocidad = 7000

func _ready():
	set_process(true)


func _process(delta):
	var nodo_arbol = get_node("/root/Node")
	if !nodo_arbol.is_in_group("cinematica"):
		position.y = 640
		motion.x = -velocidad * delta
		motion = move_and_slide(motion, Vector2(0, -1))
		
		if position.x <= -40:
			position.x = 0
