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
		owner.get_node("AnimatedSprite").play("Corriendo_100")
	elif SavingSystem.leer_datos().pieles.piel2 == true:
		owner.get_node("AnimatedSprite").play("Corriendo_66")
	elif SavingSystem.leer_datos().pieles.piel1 == true:
		owner.get_node("AnimatedSprite").play("Corriendo_33")
	elif SavingSystem.leer_datos().pieles.piel0 == true:
		owner.get_node("AnimatedSprite").play("Corriendo_0")
	
	
	# Input
	owner.direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	owner.direccion.y = int(Input.is_action_pressed("tecla_s")) - int(Input.is_action_pressed("tecla_w"))
	
	# Manipulamos el sprite dependiendo de la dirección del jugador
	if owner.direccion.x == -1:
		owner.get_node("AnimatedSprite").flip_h = true
	elif owner.direccion.x == 1:
		owner.get_node("AnimatedSprite").flip_h = false
	
	# Verificamos si estamos colisionando con el suelo
	if owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding():
		owner.puede_saltar = true
	elif !owner.get_node("RayCast2D").is_colliding() and !owner.get_node("RayCast2D2").is_colliding():
		# Le indicamos la gravedad que debe de seguir
		owner.motion.y += owner.GRAVEDAD * delta
		
		if owner.motion.y > 0:
			emit_signal("terminado", "Caerse")
		
	# Salto
	if Input.is_action_just_pressed("tecla_w") and owner.puede_saltar:
		owner.motion.y = -owner.VELOCIDAD_SALTO_MAX
		owner.puede_saltar = false
		owner.get_node("SFX_Salto").play()
		
	if owner.shift and owner.direccion.x != 0:
		owner.motion.x = owner.direccion.x * owner.VELOCIDAD * delta * owner.INCREMENTADOR_DE_VELOCIDAD
		if Input.is_action_just_pressed("tecla_w"):
			emit_signal("terminado", "Saltar")
	elif !owner.shift and owner.direccion.x != 0:
		emit_signal("terminado", "Moverse")
	else:
		emit_signal("terminado", "IDLE")
	
	# Verificamos constantemente si el jugador ha tocado la piel para poder celebrar y pasar al siguiente mundo
	if owner.celebrando == true:
		emit_signal("terminado", "Celebrando")

func controlar_input(event):
	pass
	#owner.direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	#owner.shift = Input.is_action_pressed("tecla_shift")

# Señales
func _area_entro(area):
	if area.is_in_group("enemigo"):
		emit_signal("terminado", "Morir")
