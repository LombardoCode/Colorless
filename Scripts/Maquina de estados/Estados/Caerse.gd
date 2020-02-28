extends "res://Scripts/Maquina de estados/Estado.gd"

var muerte = false

func enter():
	# Conectamos la señal del Area2D del jugador
	if !owner.get_node("Area2D").is_connected("area_entered", self, "_area_entro"):
		owner.get_node("Area2D").connect("area_entered", self, "_area_entro")
	pass

func update(delta):
	# Ejecutamos la animación
	# Dependiendo del save será la animación que se reproducirá
	if SavingSystem.leer_datos().pieles.piel3 == true:
		owner.get_node("AnimatedSprite").play("IDLE_100")
	elif SavingSystem.leer_datos().pieles.piel2 == true:
		owner.get_node("AnimatedSprite").play("IDLE_66")
	elif SavingSystem.leer_datos().pieles.piel1 == true:
		owner.get_node("AnimatedSprite").play("IDLE_33")
	elif SavingSystem.leer_datos().pieles.piel0 == true:
		owner.get_node("AnimatedSprite").play("IDLE_0")
	
	# Input
	owner.direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	owner.direccion.y = int(Input.is_action_pressed("tecla_s")) - int(Input.is_action_pressed("tecla_w"))
	owner.shift = Input.is_action_pressed("tecla_shift")
	
	# Le indicamos hacia dónde debe de voltear el personaje
	if owner.direccion.x == -1:
		owner.get_node("AnimatedSprite").flip_h = true
	elif owner.direccion.x == 1:
		owner.get_node("AnimatedSprite").flip_h = false
	
	# Le indicamos su movimiento horizontal
	if !owner.shift:
		owner.motion.x = owner.direccion.x * owner.VELOCIDAD * delta
	else:
		owner.motion.x = owner.direccion.x * owner.VELOCIDAD * delta * owner.INCREMENTADOR_DE_VELOCIDAD
	
	
	# Si estamos colisionando
	if owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding():
		emit_signal("terminado", "IDLE")
	# Si no estamos colisionando
	elif !owner.get_node("RayCast2D").is_colliding() and !owner.get_node("RayCast2D2").is_colliding():
		# Le indicamos la gravedad que debe de seguir
		owner.motion.y += owner.GRAVEDAD * delta
		
		if Input.is_action_just_pressed("tecla_w") and owner.puede_saltar:
			emit_signal("terminado", "Saltar")
			
		if Input.is_action_just_pressed("tecla_w") and owner.doble_salto:
			#emit_signal("terminado", "Saltar")
			owner.motion.y = -owner.VELOCIDAD_SALTO_MAX
			owner.doble_salto = false
			owner.saltando_doble = true
		if Input.is_action_just_released("tecla_w") and owner.motion.y < -200:
			owner.motion.y = -200
			
		#if Input.is_action_just_pressed("tecla_w") and !owner.puede_saltar and owner.tiempo_antes_del_proximo_salto > 0:
			#emit_signal("terminado", "Saltar")
		#if Input.is_action_just_pressed("tecla_w") and owner.doble_salto:
		#if Input.is_action_pressed("tecla_w") and owner.doble_salto:
			#emit_signal("terminado", "Salto_doble")
		
	pass
	
	# Si el jugador cae del mundo, que muera y que se reinicie el nivel
	if owner.position.y > Global.obtener_tamanio_ventana().y + 50:
		#Global.animacion_nivel.crecer()
		if !muerte:
			Global.animacion_nivel.crecer()
			muerte = true
	
	# Verificamos constantemente si el jugador ha tocado la piel para poder celebrar y pasar al siguiente mundo
	if owner.celebrando == true:
		emit_signal("terminado", "Celebrando")

func controlar_input(event):
	pass

# Señales
func _area_entro(area):
	if area.is_in_group("enemigo"):
		emit_signal("terminado", "Morir")

