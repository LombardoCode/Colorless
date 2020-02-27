extends KinematicBody2D

export(bool) var b_mov_h = false
export(bool) var b_mov_v = false
export(float) var desplazamiento
export(float) var direccion

var motion = Vector2()
var area

func _ready():
	pass

func _process(delta):
	$Label.text = str(direccion)
	if b_mov_h == true:
		if $Ray_izq.is_colliding() and $Ray_izq.get_collider().is_in_group("tilemap"):
			direccion = 1
		#elif $Ray_izq.is_colliding() and $Ray_izq.get_collider().name == "Personaje":
		#	Global.personaje.muerto = true
		if $Ray_der.is_colliding() and $Ray_der.get_collider().is_in_group("tilemap"):
			direccion = -1
		#elif $Ray_der.is_colliding() and $Ray_der.get_collider().name == "Personaje":
		#	Global.personaje.muerto = true
		if direccion == 1:
			motion = Vector2(desplazamiento, 0)
		elif direccion == -1:
			motion = Vector2(-desplazamiento, 0)
		motion = move_and_slide(motion, Vector2(0, -1))
		
		for i in range(get_slide_count()):
			var collision = get_slide_collision(i)
			var nombre_colisionador = collision.collider.name
			if nombre_colisionador == "Personaje":
				Global.personaje.muerto = true
		
		

