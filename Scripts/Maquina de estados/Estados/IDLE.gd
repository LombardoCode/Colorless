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
	owner.shift       = int(Input.is_action_pressed("tecla_shift"))
	
	# Movimiento horizontal
	owner.motion.x = owner.direccion.x * owner.VELOCIDAD * delta
	
	# Morir
	if Input.is_action_just_pressed("tecla_s"):
		emit_signal("terminado", "Morir")
	
	# Salto
	#if Input.is_action_pressed("tecla_w") and owner.puede_saltar:
	
	# Colisiones
	if owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding():
		# Movimiento
		if owner.direccion.x != 0:
			emit_signal("terminado", "Moverse")
		
		# Salto
		owner.puede_saltar = true
		owner.doble_salto = false
		
	elif !owner.get_node("RayCast2D").is_colliding() and !owner.get_node("RayCast2D2").is_colliding():
		# Le indicamos la gravedad que debe de seguir
		owner.motion.y += owner.GRAVEDAD * delta
		
		# Si al caminar se nos acaba el suelo...
		if owner.motion.y > 0:
			emit_signal("terminado", "Caerse")
		elif owner.motion.y < 0:
			emit_signal("terminado", "Saltar")
	
	# Verificamos constantemente si el jugador ha tocado la piel para poder celebrar y pasar al siguiente mundo
	if owner.celebrando == true:
		emit_signal("terminado", "Celebrando")
	
	# Verificamos constantemente si hemos muerto
	if owner.muerto == true:
		emit_signal("terminado", "Morir")
	

func controlar_input(event):
	if Input.is_action_just_pressed("tecla_w") and owner.puede_saltar:
		emit_signal("terminado", "Saltar")
	pass

# Señales
func _area_entro(area):
	if area.is_in_group("enemigo"):
		emit_signal("terminado", "Morir")

