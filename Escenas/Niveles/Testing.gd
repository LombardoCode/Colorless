extends KinematicBody2D

var motion = Vector2()
var snap = Vector2(0, 0)
var UP = Vector2(0, -1)
const VELOCIDAD = 250

func _ready():
	pass


func _process(delta):
	motion.x = VELOCIDAD
	motion = move_and_slide(motion, UP)
	#motion = move_and_slide_with_snap(motion, snap, UP)
	pass
