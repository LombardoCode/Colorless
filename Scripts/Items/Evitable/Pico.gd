extends KinematicBody2D

export(bool) var b_mov_h = false
export(bool) var b_mov_v = false
export(float) var desplazamiento
export(float) var direccion

# Trampa
export(bool) var trampa
var trampa_activada = false
export(bool) var mov_trampa_h
export(bool) var mov_trampa_v
export(int) var trampa_direccion
export(float) var trampa_velocidad
export(bool) var trampa_inciar_auto = false

# Visibilidad
#onready var visibility_notifier = $VisibilityNotifier2D


var motion = Vector2()
var area

func _ready():
	# Activamos el Area2D
	if self.has_node("Area2D_Trampa"):
		$Area2D_Trampa.connect("body_entered", self, "_activar_trampa")
	
	# Activamos el VisibilityNotifier
	var visibility_notifier = VisibilityNotifier2D.new()
	add_child(visibility_notifier)
	visibility_notifier.rect = Rect2(-20, -20, 40, 40)
	
	visibility_notifier.connect("screen_exited", self, "screen_exit")
	visibility_notifier.connect("screen_entered", self, "screen_enter")

func _process(delta):
	$Label.text = str(direccion)
	if !trampa:
		if b_mov_h == true:
			if $Ray_izq.is_colliding() and $Ray_izq.get_collider().is_in_group("tilemap"):
				direccion = 1
			if $Ray_der.is_colliding() and $Ray_der.get_collider().is_in_group("tilemap"):
				direccion = -1
			if direccion == 1:
				motion = Vector2(desplazamiento, 0)
			elif direccion == -1:
				motion = Vector2(-desplazamiento, 0)
			motion = move_and_slide(motion, Vector2(0, -1))
	else:
		pass
		
	for i in range(get_slide_count()):
		var collision = get_slide_collision(i)
		var nombre_colisionador = collision.collider.name
		if nombre_colisionador == "Personaje":
			Global.personaje.muerto = true
	
	if trampa_activada or trampa_inciar_auto:
		if trampa:
			if mov_trampa_h:
				motion = move_and_slide(Vector2(trampa_velocidad * trampa_direccion, 0), Vector2(0, -1))
			elif mov_trampa_v:
				motion = move_and_slide(Vector2(0, trampa_velocidad * trampa_direccion), Vector2(0, -1))
	
	
func _activar_trampa(body):
	if body.get_name() == "Personaje":
		trampa_activada = true
	
func screen_exit():
	self.hide()

func screen_enter():
	self.show()

