extends Node

var personaje
var screen_size
var coordenadas_pantalla_actual = Vector2()
var transicion
# Animaciones
var animacion_nivel # Animación cuando inicia un nuevo nivel
var animacion_flash # Animación que se reproduce cada vez que el jugador consigue una piel nueva
var contador_de_muertes
var btn_volver

# Música
var audioStreamPlayer
var cancion_cinematica
var lista_de_canciones = {
	menu_principal = "res://Recursos/Musica/Menu/menu.ogg",
	tutorial = "res://Recursos/Musica/Tutorial/Tutorial.ogg",
	arrival = "res://Recursos/Musica/Arrival/Arrival.ogg",
	wisdom = "res://Recursos/Musica/Wisdom/Wisdom.ogg",
	madness = "res://Recursos/Musica/Madness/Madness.ogg",
	creditos = "res://Recursos/Musica/Creditos/Creditos.ogg",
}

var lista_de_sonidos = {
	transicion_nivel = "res://Recursos/SFX/Transiciones_portal/transicion_nivel.wav",
	transicion_mundo = "res://Recursos/SFX/Transiciones_portal/transicion_mundo.wav",
	repetir_nivel = "res://Recursos/SFX/repetir_nivel.wav",
	repetir_nivel_reverseado = "res://Recursos/SFX/repetir_nivel_reverseado.wav"
}

var nodo_arbol

var audio_portal
var audio_repetir_nivel

func _ready():
	# Creamos un audio global
	audioStreamPlayer = AudioStreamPlayer.new()
	audioStreamPlayer.volume_db = -80
	
	# Creamos un AudioStreamPlayer para los sonidos de los dos portales
	audio_portal = AudioStreamPlayer.new()
	add_child(audio_portal)
	
	audio_repetir_nivel = AudioStreamPlayer.new()
	add_child(audio_repetir_nivel)
	
	# Reproducimos automaticamente la canción dependiendo del tipo de grupo en el que esté el nodo
	reproducir_musica()
	set_process(true)


func reproducir_musica():
	if !get_node("/root/Global").has_node("Musica"):
		# Creamos un AudioStreamPlayer dinámicamente y lo agregamos al nodo de Global
		
		audioStreamPlayer.set_name("Musica")
		add_child(audioStreamPlayer)
		
		# Determinamos que canción reproducir de acuerdo al nivel en el que estamos
		if get_node("/root/Node") != null:
			nodo_arbol = get_node("/root/Node")
			var audio = obtenerAudioCorrespondiente()
		
			# De acuerdo al nivel en el que estamos seteamos el stream de nuestro AudioStreamPlayer
			audioStreamPlayer.stream = audio
			
			# Si no se está reproduciendo nada, que se reproduzca
			if !audioStreamPlayer.is_playing():
				audioStreamPlayer.play()
	else:
		# Obtenemos el AudioStream que está actualmente reproduciendose en Global y obtenemos su stream
		var audioStream = get_node("/root/Global/Musica")
		var stream_actual = audioStream.get_stream() 
		
		# Obtenemos el nodo árbol y obtenemos el audio correspondiente dependiendo del grupo en el que...
		# ...esté el nodo arbol
		if get_node("/root/Node") != null:
			nodo_arbol = get_node("/root/Node")
			var audio = obtenerAudioCorrespondiente()
			
			# Verificamos si el stream actual es igual al del stream nuevo
			if stream_actual != audio:
				audioStream.stream = audio
				audioStream.play()


func obtenerAudioCorrespondiente():
	if nodo_arbol.is_in_group("menu_principal"):
		return load(lista_de_canciones.menu_principal)
	if nodo_arbol.is_in_group("tutorial"):
		return load(lista_de_canciones.tutorial)
	if nodo_arbol.is_in_group("arrival"):
		return load(lista_de_canciones.arrival)
	elif nodo_arbol.is_in_group("wisdom"):
		return load(lista_de_canciones.wisdom)
	elif nodo_arbol.is_in_group("madness"):
		return load(lista_de_canciones.madness)
	elif nodo_arbol.is_in_group("creditos"):
		return load(lista_de_canciones.creditos)
	else:
		return 


func _process(_delta):
	pass


func get_coordenadas():
	# Obtenemos el tamaño de la ventana
	screen_size = get_viewport().get_visible_rect().size
	
	# Obtenemos las coordenadas del jugador (ejemplo: Vector2(1, 0))
	if personaje:
		var pos_x = floor(personaje.global_position.x / get_viewport().get_visible_rect().size.x)
		var pos_y = floor(personaje.global_position.y / get_viewport().get_visible_rect().size.y)
		coordenadas_pantalla_actual = Vector2(pos_x, pos_y)
		return coordenadas_pantalla_actual

func pasar_al_siguiente_nivel(escena_target):
	if transicion != null:
		var animation_player = transicion.get_node("AnimationPlayer")
		animation_player.connect("animation_finished", self, "animacion_finalizada", [escena_target])
		animation_player.play("fade_in")
	
func animacion_finalizada(anim_name, escena_target):
	get_tree().change_scene(escena_target)

func obtener_tamanio_ventana():
	screen_size = get_viewport().get_visible_rect().size
	return screen_size

func reproducir_audio_portal_nivel():
	var cancion_a_reproducir = load(lista_de_sonidos.transicion_nivel)
	audio_portal.stream = cancion_a_reproducir
	audio_portal.play()

func reproducir_audio_portal_mundo():
	var cancion_a_reproducir = load(lista_de_sonidos.transicion_mundo)
	audio_portal.stream = cancion_a_reproducir
	audio_portal.play()

func reproducir_audio_repetir_nivel():
	var cancion_a_reproducir = load(lista_de_sonidos.repetir_nivel)
	audio_repetir_nivel.stream = cancion_a_reproducir
	audio_repetir_nivel.volume_db = 5
	audio_repetir_nivel.pitch_scale = 1.2
	audio_repetir_nivel.play()

func reproducir_audio_repetir_nivel_reverseado():
	var cancion_a_reproducir = load(lista_de_sonidos.repetir_nivel_reverseado)
	audio_repetir_nivel.stream = cancion_a_reproducir
	audio_repetir_nivel.volume_db = 0
	audio_repetir_nivel.pitch_scale = 1.2
	audio_repetir_nivel.play()


func obtener_audio_global():
	return audioStreamPlayer
