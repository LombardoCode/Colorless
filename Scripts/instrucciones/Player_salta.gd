extends KinematicBody2D

var motion = Vector2()
var GRAVEDAD = 30
var ALTURA = 600


func _ready():
	set_process(true)


func _process(delta):
	if self.is_on_floor():
		motion.y -= ALTURA
	else:
		motion.y += GRAVEDAD
	motion = move_and_slide(motion, Vector2(0, -1))
		
