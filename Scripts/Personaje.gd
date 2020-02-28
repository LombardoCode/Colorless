extends KinematicBody2D

var motion = Vector2()
var UP = Vector2(0, -1)
const VELOCIDAD = 17000 #17000 #15000
const INCREMENTADOR_DE_VELOCIDAD = 1.4
var salto_habilitado = false



# Salto y gravedad
var GRAVEDAD #= 1300 #2000 #1800 #DEBUG: 800
var VELOCIDAD_SALTO_MAX # = 30000 #40000
var VELOCIDAD_SALTO_MIN # = 0
var ALTURA_SALTO_MAX = (16 * 2.5) + 100
var ALTURA_SALTO_MIN = (16 * 2.5) + 70
var DURACION_SALTO = 0.36
var snap



#var en_el_aire = false
var puede_saltar = true
var saltando_doble = false
var primer_salto = false
var doble_salto = false

var shift = false
var debug_msgs = false

var screen_size = OS.window_size
var limite_mundo_inferior = screen_size.y
var direccion = Vector2()
var label
var ray_label
var label_ps
var sonido_tiempo = 0

var prueba

# Salto tiempo
var cooldown_proximo_salto = 2
var tiempo_antes_del_proximo_salto = 0

# Celebrando
var celebrando = false

# Muerte
var muerto = false

func _ready():
	# Conectamos la señal del Area2D del jugador
	if !self.get_node("Area2D").is_connected("area_entered", self, "_area_entro"):
		self.get_node("Area2D").connect("area_entered", self, "_area_entro")
	
	#prueba = self.get_parent().get_node("Interfaz/Label")
	Global.personaje = self
	GRAVEDAD = 2 * ALTURA_SALTO_MAX / pow(DURACION_SALTO, 2)
	VELOCIDAD_SALTO_MAX = sqrt(2 * GRAVEDAD * ALTURA_SALTO_MAX)
	VELOCIDAD_SALTO_MIN = sqrt(2 * GRAVEDAD * ALTURA_SALTO_MIN)
	# Screenshot
	#yield(get_tree(),"idle_frame")
	#yield(get_tree(),"idle_frame")
	#var img = get_viewport().get_texture().get_data()
	#img.flip_y()
	#img.resize(1280,720)
	#img.save_png("user://1.png")
	#
	#self.global_position = Vector2((1280 * 3) + 400, 500)
	#self.global_position = Vector2((1280 * 3) + 700, 300)
	#
	label = get_node("Estado")
	ray_label = get_node("Ray")
	label_ps = get_node("Puede_saltar")
	Global.personaje = self
	set_process(true)

func _process(delta):
	tiempo_antes_del_proximo_salto -= delta
	# Limitamos la gravedad
	if motion.y > 500:
		motion.y = 500
	
	#prueba.text = "Gravedad: " + str(self.motion.y)
	#prueba.text = "Gravedad: " + str(self.tiempo_antes_del_proximo_salto)
	#get_node("../Interfaz/Label").text = str(motion.y)
	label_ps.text = "Puede saltar: " + str(puede_saltar) + "\nDoble salto: " + str(doble_salto) + "\nPrimer_salto: " + str(primer_salto) + "\nSaltando_doble: " + str(saltando_doble) + "\nGravedad: " + str(motion.y)
	#label_ps.text = "Puede saltar: " + str(puede_saltar) + "\nDoble salto: " + str(doble_salto) + "\nPrimer_salto: " + str(primer_salto) + "\nGravedad: " + str(motion.y)
	#+ "\nEn el aire: " + str(en_el_aire)
	
	#ray_label.text = "Ray: " + str(self.get_node("RayCast2D").is_colliding())

	# Movimiento (X y Y)
	#motion = move_and_slide(motion, UP)
	if $RayCast2D.is_colliding() or $RayCast2D2.is_colliding():
		snap = Vector2.DOWN * 1
	else:
		snap = Vector2.ZERO
	#var snap = Vector2.DOWN * 32 if puede_saltar else Vector2.ZERO
	motion = move_and_slide_with_snap(motion, snap, UP)
	#motion = move_and_slide_with_snap(motion, UP)
	#motion = move_and_slide_with_snap(motion, Vector2(0, 0), UP, false, 4, 0.785398, true)
	#motion = move_and_slide_with_snap(motion, Vector2(0, 0), UP)
	
	#motion = move_and_slide_with_snap(motion, Vector2(0, 0), UP)
	
	# Collision con el grupo "Coleccionables"
	#var cantidad_colisionadores = self.get_slide_count()
	#if cantidad_colisionadores > 0:
	#	for i in cantidad_colisionadores:
	#		if get_slide_collision(i).collider.is_in_group("Coleccionable"):
	#			print("Estas tocando a un coleccionable")
	
	# Collision con el grupo "Coleccionables"
	
	# Reiniciar el nivel con una tecla
	if Input.is_action_pressed("ui_page_up"):
		return get_tree().reload_current_scene()


func muerte():
	if sonido_tiempo == 0:
		var timer_sonido = Timer.new()
		timer_sonido.set_one_shot(true)
		timer_sonido.set_wait_time(0.3)
		timer_sonido.connect("timeout", self, "muerte2")
		add_child(timer_sonido)
		timer_sonido.start()
		sonido_tiempo = sonido_tiempo + 1

func muerte2():
	$SFX_Caida.play()
	var timer_reubicar_jugador = Timer.new()
	timer_reubicar_jugador.set_one_shot(true)
	timer_reubicar_jugador.set_wait_time(1)
	timer_reubicar_jugador.connect("timeout", self, "reubicar_jugador")
	add_child(timer_reubicar_jugador)
	timer_reubicar_jugador.start()

func reubicar_jugador():
	#self.get_node("MaquinaDeEstados").activar_estado(true)
	if Global.get_coordenadas().x == 1:
		self.global_position.x = (1 * Global.obtener_tamanio_ventana().x) + 100
		self.global_position.y = (0 * Global.obtener_tamanio_ventana().y) + 400

