extends Node

onready var nodo_arbol = get_node("/root/Node")

func _ready():
	# Mandamos a llamar esta función cada se inicie un nuevo nivel
	# Fundamental en el transición de mundos donde la canción es distinta
	#SavingSystem.guardar_datos(SavingSystem.datos_a_guardar)
	
	# Reproducimos la canción correspondiente al nivel
	Global.reproducir_musica()
	
	if nodo_arbol.is_in_group("cinematica"):
		pass
	
	var audioStreamPlayer = Global.obtener_audio_global()
	if audioStreamPlayer.get_volume_db() == -80:
		var tween_musica = Tween.new()
		add_child(tween_musica)
		tween_musica.interpolate_property(audioStreamPlayer, "volume_db", audioStreamPlayer.get_volume_db(), 0, 0.8, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween_musica.start()

