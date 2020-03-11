extends Node

var datos_obtenidos
var timer
var tiempo_desde = 2
var tiempo_hasta = 3.4
var tiempo_aleatorio
var tiempo_transcurrido = 0
var animacion_cambiada = false
onready var fade_in = $Interfaz/Fade_in/AnimationPlayer

func _ready():
	# Reproducimos la canción correspondiente al nivel
	Global.reproducir_musica()
	# Obtenemos los datos actuales de nuestra partida
	datos_obtenidos = SavingSystem.leer_datos()
	
	randomize()
	#var tiempo_aleatorio = rand_range(1.5, 3.0)
	tiempo_aleatorio = rand_range(tiempo_desde, tiempo_hasta)
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = tiempo_aleatorio
	timer.start()
	
	set_process(true)

func _process(delta):
	tiempo_transcurrido += delta
	
	if ((tiempo_transcurrido > (tiempo_aleatorio - 0.5)) and (tiempo_transcurrido < tiempo_aleatorio)) and !animacion_cambiada:
		fade_out()

func fade_out():
	if !animacion_cambiada:
		animacion_cambiada = true
		fade_in.connect("animation_finished", self, "_animacion_terminada")
		fade_in.play("fade_in")

func _animacion_terminada(anim_name):
	if anim_name == "fade_in":
		_tiempo_agotado()

func _tiempo_agotado():
	redireccionar_a_nivel()

func redireccionar_a_nivel():
	# ~ Madness (Tercer mundo de Colorless) ~
	if datos_obtenidos.niveles.final_madness == true:
		return get_tree().change_scene("res://Escenas/Niveles/MadnessSuperado.tscn")
	if datos_obtenidos.niveles.nivel_30 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel30.tscn")
	if datos_obtenidos.niveles.nivel_29 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel29.tscn")
	if datos_obtenidos.niveles.nivel_28 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel28.tscn")
	if datos_obtenidos.niveles.nivel_27 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel27.tscn")
	if datos_obtenidos.niveles.nivel_26 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel26.tscn")
	if datos_obtenidos.niveles.nivel_25 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel25.tscn")
	if datos_obtenidos.niveles.nivel_24 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel24.tscn")
	if datos_obtenidos.niveles.nivel_23 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel23.tscn")
	if datos_obtenidos.niveles.nivel_22 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel22.tscn")
	if datos_obtenidos.niveles.nivel_21 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel21.tscn")
	
	# ~ Wisdom (Segundo mundo de Colorless) ~
	if datos_obtenidos.niveles.final_wisdom == true:
		return get_tree().change_scene("res://Escenas/Niveles/WisdomSuperado.tscn")
	if datos_obtenidos.niveles.nivel_20 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel20.tscn")
	if datos_obtenidos.niveles.nivel_19 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel19.tscn")
	if datos_obtenidos.niveles.nivel_18 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel18.tscn")
	if datos_obtenidos.niveles.nivel_17 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel17.tscn")
	if datos_obtenidos.niveles.nivel_16 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel16.tscn")
	if datos_obtenidos.niveles.nivel_15 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel15.tscn")
	if datos_obtenidos.niveles.nivel_14 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel14.tscn")
	if datos_obtenidos.niveles.nivel_13 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel13.tscn")
	if datos_obtenidos.niveles.nivel_12 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel12.tscn")
	if datos_obtenidos.niveles.nivel_11 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel11.tscn")
		
	# ~ Arrival (Primer mundo de Colorless) ~
	if datos_obtenidos.niveles.final_arrival == true:
		return get_tree().change_scene("res://Escenas/Niveles/ArrivalSuperado.tscn")
	if datos_obtenidos.niveles.nivel_10 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel10.tscn")
	if datos_obtenidos.niveles.nivel_9 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel9.tscn")
	if datos_obtenidos.niveles.nivel_8 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel8.tscn")
	if datos_obtenidos.niveles.nivel_7 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel7.tscn")
	if datos_obtenidos.niveles.nivel_6 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel6.tscn")
	if datos_obtenidos.niveles.nivel_5 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel5.tscn")
	if datos_obtenidos.niveles.nivel_4 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel4.tscn")
	if datos_obtenidos.niveles.nivel_3 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel3.tscn")
	if datos_obtenidos.niveles.nivel_2 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel2.tscn")
	if datos_obtenidos.niveles.nivel_1 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel1.tscn")
