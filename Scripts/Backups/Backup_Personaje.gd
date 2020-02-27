extends KinematicBody2D

var motion = Vector2()
const VELOCIDAD = 17000
const GRAVEDAD = 28
const ALTURA_SALTO = 40000
const INCREMENTADOR_DE_VELOCIDAD = 1.6
var puede_saltar = true

var screen_size = OS.window_size
var limite_mundo_inferior = screen_size.y
var direccion = Vector2()


func _ready():
	Global.personaje = self
	set_process(true)

func _process(delta):
	print("gravedad: " + str(motion.y))
	# Dirección del movimiento horizontal y vertical
	direccion.x = int(Input.is_action_pressed("tecla_d")) - int(Input.is_action_pressed("tecla_a"))
	direccion.y = int(Input.is_action_pressed("tecla_s")) - int(Input.is_action_pressed("tecla_w"))
	
	# Movimiento horizontal
	motion.x = direccion.x * VELOCIDAD * delta
	
	# Impulso
	if direccion.x != 0 and Input.is_action_pressed("tecla_shift"):
		motion.x = direccion.x * VELOCIDAD * delta * INCREMENTADOR_DE_VELOCIDAD
	
	# Cambio de sprites (corriendo)
	if direccion.x == -1 or direccion.x == 1:
		if self.is_on_floor():
			$AnimatedSprite.play("Corriendo")
		elif !self.is_on_floor():
			$AnimatedSprite.play("IDLE")
		if direccion.x == -1:
			$AnimatedSprite.flip_h = true
		else:
			$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.play("IDLE")
	
	# Salto
	if self.is_on_floor():
		puede_saltar = true
		if Input.is_action_just_pressed("tecla_w") and puede_saltar == true:
			motion.y = -ALTURA_SALTO * delta
			puede_saltar = false
			
			# Reproducimos el sonido del salto
			$SFX_Salto.play()
	elif !self.is_on_floor():
		if Input.is_action_just_pressed("tecla_w") and puede_saltar == true:
			motion.y = -ALTURA_SALTO * delta
			puede_saltar = false
			
			# Reproducimos el sonido del salto
			$SFX_Salto.play()
		if Input.is_action_just_released("tecla_w") and motion.y < -400:
			motion.y = -400
		if Input.is_action_just_pressed("tecla_shift"):
			puede_saltar = true
	#elif self.is_on_ceiling():
	#	motion.y = 0
	
	# Gravedad
	if !self.is_on_floor():
		var cantidad_colisionadores = self.get_slide_count()
		if cantidad_colisionadores > 0:
			for i in cantidad_colisionadores:
				if get_slide_collision(i).collider.is_in_group("densidad_media"):
					#print("Gravedad densa")
					motion.y += 1
				else:
					#print("jeje")
					motion.y += GRAVEDAD
		else:
			#print("Gravedad normal")
			motion.y += GRAVEDAD
#			
	
	# Movimiento (X y Y)
	motion = move_and_slide(motion, Vector2(0, -1))
	
	# Acciones que realiza el player si este muere
	ha_muerto()
	
	
	# Collision con el grupo "Coleccionables"
	#var cantidad_colisionadores = self.get_slide_count()
	#if cantidad_colisionadores > 0:
	#	for i in cantidad_colisionadores:
	#		if get_slide_collision(i).collider.is_in_group("Coleccionable"):
	#			print("Estas tocando a un coleccionable")
	
	# Reiniciar el nivel con una tecla
	if Input.is_action_pressed("ui_page_up"):
		return get_tree().reload_current_scene()

func ha_muerto():
	pass
	#if self.global_position.y > limite_mundo_inferior + 20:
		#return get_tree().reload_current_scene()
