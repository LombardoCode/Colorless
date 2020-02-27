extends "res://Scripts/Maquina de estados/Estado.gd"

func enter():
	# Conectamos la señal del Area2D del jugador
	if !owner.get_node("Area2D").is_connected("area_entered", self, "_area_entro"):
		owner.get_node("Area2D").connect("area_entered", self, "_area_entro")
	owner.tiempo_antes_del_proximo_salto = owner.cooldown_proximo_salto
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
	
	
	# Si estás colisionando con el suelo...
	if (owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding()):
		emit_signal("terminado", "IDLE")
	if (owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding()) and owner.puede_saltar:
		owner.puede_saltar = false
		#if Input.is_action_pressed("tecla_w") :
		owner.motion.y = -owner.VELOCIDAD_SALTO_MAX
		#emit_signal("terminado", "IDLE")
	elif !owner.get_node("RayCast2D").is_colliding() and !owner.get_node("RayCast2D2").is_colliding():
		# Le indicamos la gravedad que debe de seguir
		owner.motion.y += owner.GRAVEDAD * delta
		
		if Input.is_action_pressed("tecla_w") and owner.puede_saltar:
			owner.motion.y = -owner.VELOCIDAD_SALTO_MAX
			owner.puede_saltar = false
		if Input.is_action_just_pressed("tecla_w") and owner.doble_salto:
			emit_signal("terminado", "Salto_doble")
		
		# Si suelta el botón
		#if Input.is_action_just_released("tecla_w") and owner.motion.y < owner.VELOCIDAD_SALTO_MIN:
		if Input.is_action_just_released("tecla_w") and owner.motion.y < -200:
			owner.motion.y = -200
#			if owner.motion.y > -450:
#				owner.motion.y = 1
#				print("Se dejó de presionar: " + str(owner.motion.y))
		
		if owner.motion.y > 0:
			emit_signal("terminado", "Caerse")
		
	# Verificamos constantemente si el jugador ha tocado la piel para poder celebrar y pasar al siguiente mundo
	if owner.celebrando == true:
		emit_signal("terminado", "Celebrando")


func controlar_input(event):
	pass

# Señales
func _area_entro(area):
	if area.is_in_group("enemigo"):
		emit_signal("terminado", "Morir")
