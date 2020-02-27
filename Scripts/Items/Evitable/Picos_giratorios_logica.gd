extends KinematicBody2D

export(bool) var b_mov_v
export(bool) var b_mov_h
export(int) var direccion
var motion = Vector2()
export(float) var desplazamiento
export(float) var velocidad_giro

func _ready():
	pass

func _process(delta):
	if b_mov_v == true:
		if $ray_arriba.is_colliding() and $ray_arriba.get_collider().is_in_group("tilemap"):
			direccion = 1
		if $ray_abajo.is_colliding() and $ray_abajo.get_collider().is_in_group("tilemap"):
			direccion = -1
		if direccion == 1:
			motion = Vector2(0, desplazamiento)
		elif direccion == -1:
			motion = Vector2(0, -desplazamiento)
		motion = move_and_slide(motion, Vector2(0, -1))
	if b_mov_h == true:
		if $ray_izq.is_colliding() and $ray_izq.get_collider().is_in_group("tilemap"):
			direccion = 1
		if $ray_der.is_colliding() and $ray_der.get_collider().is_in_group("tilemap"):
			direccion = -1
		if direccion == 1:
			motion = Vector2(desplazamiento, 0)
		elif direccion == -1:
			motion = Vector2(-desplazamiento, 0)
		motion = move_and_slide(motion, Vector2(0, -1))
