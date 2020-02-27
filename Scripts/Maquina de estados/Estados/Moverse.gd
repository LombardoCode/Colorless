extends "res://Scripts/Maquina de estados/Estado.gd"

func enter():
	# Conectamos la señal del Area2D del jugador
	if !owner.get_node("Area2D").is_connected("area_entered", self, "_area_entro"):
		owner.get_node("Area2D").connect("area_entered", self, "_area_entro")
	pass

func update(delta):
	# Ejecutamos la animación
	# Dependiendo del save será la animación que se reproducirá
	if SavingSystem.leer_datos().pieles.piel3 == true:
		owner.get_node("AnimatedSprite").play("Caminando_100")
	elif SavingSystem.leer_datos().pieles.piel2 == true:
		owner.get_node("AnimatedSprite").play("Caminando_66")
	elif SavingSystem.leer_datos().pieles.piel1 == true:
		owner.get_node("AnimatedSprite").play("Caminando_33")
	elif SavingSystem.leer_datos().pieles.piel0 == true:
		owner.get_node("AnimatedSprite").play("Caminando_0")
	
	owner.direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	owner.shift = Input.is_action_pressed("tecla_shift")
	
	# Nos movemos con respecto a la dirección
	owner.motion.x = owner.direccion.x * owner.VELOCIDAD * delta
	
	# Si ya no presionamos ni izquierda ni derecha nos pasamos al estado «IDLE»
	if owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding():
		# Si no se mueve...
		if owner.direccion.x == 0:
			emit_signal("terminado", "IDLE")
		
		
		# Manipular el sprite dependiendo de la dirección del jugador
		if owner.direccion.x != 0:
			if owner.direccion.x == -1:
				owner.get_node("AnimatedSprite").flip_h = true
			elif owner.direccion.x == 1:
				owner.get_node("AnimatedSprite").flip_h = false
			
			# Salto
			if Input.is_action_just_pressed("tecla_w"):
				emit_signal("terminado", "Saltar")
			
			# Correr
			if owner.shift:
				emit_signal("terminado", "Correr")
	elif !owner.get_node("RayCast2D").is_colliding() and !owner.get_node("RayCast2D2").is_colliding():
		# Le indicamos la gravedad que debe de seguir
		owner.motion.y += owner.GRAVEDAD * delta
		
		if owner.motion.y > 0:
			emit_signal("terminado", "Caerse")
	
	# Verificamos constantemente si el jugador ha tocado la piel para poder celebrar y pasar al siguiente mundo
	if owner.celebrando == true:
		emit_signal("terminado", "Celebrando")
	
	
#	if owner.motion.y > 0 and (!owner.get_node("RayCast2D").is_colliding() and !owner.get_node("RayCast2D2").is_colliding()):
#		if owner.debug_msgs:print("Ya NO se está colisionando2")
#		#if owner.get_node("RayCast2D").is_colliding() and owner.get_node("RayCast2D2").is_colliding():
#		emit_signal("terminado", "Caerse")

func controlar_input(event):
	pass

# Señales
func _area_entro(area):
	if area.is_in_group("enemigo"):
		emit_signal("terminado", "Morir")
