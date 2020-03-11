extends "res://Scripts/Maquina de estados/Estado.gd"

var timer
onready var nodo_arbol = get_node("/root/Node")

func enter():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_tiempo_agotado")
	timer.wait_time = 1
	timer.one_shot = true
	timer.start()
	pass

func update(delta):
	# Reproducimos el sonido cuando recolectamos una piel
	if !owner.piel_recolectada:
		owner.get_node("SFX_piel").play()
		owner.piel_recolectada = true
	# Desactivamos la máquina de estados y hacemos que el personaje deje de moverse
	#.activar_estado(false)
	owner.motion = Vector2(0, 0)
	
	# Creamos un Tween para que el jugador cambie a blanco y reaparezca con su nueva skin
	pass

func controlar_input(event):
	pass


# Señales
func _tiempo_agotado():
	#.activar_estado(true)
	# Hacemos que el personaje camine automaticamente sin el jugador (solo si se trata del último mundo (Madness))
	if !nodo_arbol.is_in_group("madness"):
		emit_signal("terminado", "Caerse")
	else:
		emit_signal("terminado", "Caminata_final")
	timer.queue_free()
