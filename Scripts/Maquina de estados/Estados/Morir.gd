extends "res://Scripts/Maquina de estados/Estado.gd"

var valor_aleatorio

var escena_particula_muerte = preload("res://Escenas/Items/Particulas/ParticulaMuerte.tscn")
var particula_muerte

func enter():
	# Conectamos la señal del Area2D del jugador
	if !owner.get_node("Area2D").is_connected("area_entered", self, "_area_entro"):
		owner.get_node("Area2D").connect("area_entered", self, "_area_entro")
	
	# Le quitamos su máscara de colisiones
	if owner.has_node("CollisionShape2D"):
		owner.get_node("CollisionShape2D").queue_free()
	
	# Desactivamos su máquina de estados
	.activar_estado(false)
	
	# Desaparecemos al jugador
	owner.visible = false
	
	# Instanciamos la particula
	particula_muerte = escena_particula_muerte.instance()
	
	# La colocamos donde está el jugador
	particula_muerte.position = owner.position
	
	# Y la agregamos al árbol
	get_node("/root/Node/").add_child(particula_muerte)
	
	# Creamos un timer para resetear el nivel actual
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "reiniciar_nivel")
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.start()
	#get_node("/root/Node/Personaje").call_deferred("add_child", particula_muerte)
	#print(get_parent().get_parent().get_name())
	
	
	
	
	
	
	#var rand = Vector2(rand_range(-amplitud, amplitud), rand_range(-amplitud, amplitud))
	#var camara = owner.get_parent().get_node("Camera2D")
	
	
	#var tween = Tween.new()
	#add_child(tween)
	
	#tween.interpolate_property(camara, "offset", camara.offset, rand, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	#tween.start()
#	tween.interpolate_property(owner, "scale", owner.get_scale(), Vector2(0.6, 0.6), 1.0, Tween.TRANS_BACK, Tween.EASE_IN)
#	tween.interpolate_property(owner, "position", owner.get_position(), Vector2(owner.get_position().x, 800), 1.0, Tween.TRANS_BACK, Tween.EASE_IN)
#	tween.start()
	pass

func update(delta):
	# Le prohibimos moverse
	owner.motion = Vector2(0, 0)
	
	valor_aleatorio = ceil(rand_range(-4, 3))
	pass

func controlar_input(event):
	pass

func reiniciar_nivel():
	Global.animacion_nivel.crecer()

# Señales
func _area_entro(area):
	if area.is_in_group("enemigo"):
		emit_signal("terminado", "Morir")
