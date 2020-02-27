extends "res://Scripts/Maquina de estados/Estado.gd"

var timer

func enter():
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_tiempo_agotado")
	timer.wait_time = 1
	timer.one_shot = true
	timer.start()
	pass

func update(delta):
	# Desactivamos la máquina de estados y hacemos que el personaje deje de moverse
	.activar_estado(false)
	owner.motion = Vector2(0, 0)
	
	# Creamos un Tween para que el jugador cambie a blanco y reaparezca con su nueva skin
	pass

func controlar_input(event):
	pass


# Señales
func _tiempo_agotado():
	#.activar_estado(true)
	emit_signal("terminado", "Caerse")
	timer.queue_free()
