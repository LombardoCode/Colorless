extends Node

var personaje
var screen_size
var coordenadas_pantalla_actual = Vector2()
var transicion
# Animaciones
var animacion_nivel # Animación cuando inicia un nuevo nivel
var animacion_flash # Animación que se reproduce cada vez que el jugador consigue una piel nueva

# Música
var lista_de_canciones = {
	menu_principal = "res://Recursos/Musica/Menu/menu.ogg",
	tutorial = "res://Recursos/Musica/Tutorial/Tutorial.ogg",
	arrival = "res://Recursos/Musica/Arrival/Arrival.ogg",
	wisdom = "res://Recursos/Musica/Wisdom/Wisdom.ogg",
	madness = "res://Recursos/Musica/Madness/Madness.ogg"
}

var nodo_arbol


func _ready():
	reproducir_musica()
	set_process(true)


func reproducir_musica():
	if !get_node("/root/Global").has_node("Musica"):
		# Creamos un AudioStreamPlayer dinámicamente y lo agregamos al nodo de Global
		var audioStreamPlayer = AudioStreamPlayer.new()
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
