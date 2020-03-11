extends Node

var musica
export (String) var nombre_nivel
export (String) var nivel
onready var nodo_arbol = get_node("/root/Node")

func _ready():
	# Verificamos si el audioStreamPlayer no está silenciado
	var audioStreamPlayer = Global.obtener_audio_global()
	if audioStreamPlayer.get_volume_db() < -20:
		var tween_musica = Tween.new()
		add_child(tween_musica)
		tween_musica.interpolate_property(audioStreamPlayer, "volume_db", audioStreamPlayer.get_volume_db(), 0, 0.8, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween_musica.start()
	
	# Reproducimos la canción correspondiente al nivel
	Global.reproducir_musica()
	
	if !nodo_arbol.is_in_group("creditos"):
		# Iniciamos le nivel con una animación de entrada
		Global.animacion_nivel.decrecer()
	
	# Indicador de niveles dentro del GameState
	if get_node("Interfaz").has_node("Indicador_nivel/Texto_nivel"):
		$Interfaz/Indicador_nivel/Texto_nivel.text = nombre_nivel
	
	# Esta línea la agrego debido a que yo pienso personalmente que se
	# trata de un bug del motor. Especifico explicitamente que mi
	# variable "nivel" es de tipo String (otra vez pese a que ya lo
	# definí arriba en la declaración de variables).
	nivel = String(nivel)
	
	# Hacemos una validación en caso de que el jugador esté
	# en uno de los 3 niveles finales; en caso de que lo esté
	# Le quitamos la piel correspondiente a obtener en caso de que el
	# jugador decida reiniciar el nivel o recargar la partida en el
	# nivel en el que estaba
	if nivel == "final_arrival":
		# Recuperamos los datos actuales de la partida
		var datos_nuevos = SavingSystem.leer_datos()
		
		# Le quitamos la piel a obtener
		datos_nuevos.pieles.piel1 = false
		datos_nuevos.pieles.piel2 = false
		datos_nuevos.pieles.piel3= false
		
		# Guardamos los datos al archivo
		SavingSystem.guardar_datos(datos_nuevos)
	if nivel == "final_wisdom":
		# Recuperamos los datos actuales de la partida
		var datos_nuevos = SavingSystem.leer_datos()
		
		# Le quitamos la piel a obtener
		datos_nuevos.pieles.piel2 = false
		datos_nuevos.pieles.piel3 = false
		
		# Guardamos los datos al archivo
		SavingSystem.guardar_datos(datos_nuevos)
	if nivel == "final_madness":
		# Recuperamos los datos actuales de la partida
		var datos_nuevos = SavingSystem.leer_datos()
		
		# Le quitamos la piel a obtener
		datos_nuevos.pieles.piel3 = false
		
		# Guardamos los datos al archivo
		SavingSystem.guardar_datos(datos_nuevos)
