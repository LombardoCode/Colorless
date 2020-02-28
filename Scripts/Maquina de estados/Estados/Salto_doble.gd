extends "res://Scripts/Maquina de estados/Estado.gd"

func enter():
	# Conectamos la señal del Area2D del jugador
	if !owner.get_node("Area2D").connect("area_entered", self, "_area_entro"):
		owner.get_node("Area2D").connect("area_entered", self, "_area_entro")
	pass
	
func update(delta):
	# Input
	owner.direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	owner.direccion.y = int(Input.is_action_pressed("tecla_s")) - int(Input.is_action_pressed("tecla_w"))
	owner.shift       = int(Input.is_action_pressed("tecla_shift"))
	
	# Le indicamos su movimiento horizontal
	if !owner.shift:
		owner.motion.x = owner.direccion.x * owner.VELOCIDAD * delta
	else:
		owner.motion.x = owner.direccion.x * owner.VELOCIDAD * delta * owner.INCREMENTADOR_DE_VELOCIDAD
	
	# Colisiones
	if owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding():
		emit_signal("terminado", "IDLE")
	elif !owner.get_node("RayCast2D").is_colliding() and !owner.get_node("RayCast2D2").is_colliding():
		# Le indicamos la gravedad que debe de seguir
		owner.motion.y += owner.GRAVEDAD * delta
		
		#print("mmm")
		if owner.doble_salto and !owner.saltando_doble:
			owner.motion.y = -owner.VELOCIDAD_SALTO_MAX
			owner.doble_salto = false
			owner.saltando_doble = true
		if Input.is_action_just_released("tecla_w") and owner.motion.y < -200:
			owner.motion.y = -200
		
		
		
		#if Input.is_action_pressed("tecla_w"):
		#	print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
		
		
		
		
		
		
		#if Input.is_action_pressed("tecla_w") and owner.doble_salto:
#		if Input.is_action_pressed("tecla_w") and owner.doble_salto and !owner.saltando_doble:
#			owner.saltando_doble = true
#			owner.motion.y = -owner.VELOCIDAD_SALTO_MAX
#			owner.doble_salto = false
#			emit_signal("terminado", "Saltar") # Hot-fix Bug
			
			
			
			
			
			
			
			
			
			
			
		
		# Si no estamos colisionando y el motion.y > 0 le mandamos la señal de caida
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
