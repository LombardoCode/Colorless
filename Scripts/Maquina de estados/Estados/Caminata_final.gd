extends "res://Scripts/Maquina de estados/Estado.gd"

var player_movible = false
var motion = Vector2()

func enter():
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "_tiempo_agotado")
	timer.wait_time = 1.0
	timer.start()
	
	# Y bajamos la música
	var audioStreamPlayer = Global.obtener_audio_global()
	var tween_musica = Tween.new()
	add_child(tween_musica)
	tween_musica.interpolate_property(audioStreamPlayer, "volume_db", audioStreamPlayer.get_volume_db(), -80, 4.0, Tween.TRANS_LINEAR, Tween.EASE_OUT, 1.0)
	tween_musica.start()

func update(delta):
	if player_movible:
		# Le decimos al jugador qué sprite debe de utilizar
		if SavingSystem.leer_datos().pieles.piel3 == true:
			owner.get_node("AnimatedSprite").play("Caminando_100")
		elif SavingSystem.leer_datos().pieles.piel2 == true:
			owner.get_node("AnimatedSprite").play("Caminando_66")
		elif SavingSystem.leer_datos().pieles.piel1 == true:
			owner.get_node("AnimatedSprite").play("Caminando_33")
		elif SavingSystem.leer_datos().pieles.piel0 == true:
			owner.get_node("AnimatedSprite").play("Caminando_0")
		
		# Le asignamos una gravedad
		motion.y += owner.GRAVEDAD * delta
		
		if owner.get_node("RayCast2D").is_colliding() or owner.get_node("RayCast2D2").is_colliding():
			# Le asignamos una velocidad en el eje X
			motion.x = (owner.VELOCIDAD / 3) * delta
		
		# Le indicamos el movimiento al jugador
		motion = owner.move_and_slide(motion, Vector2(0, -1))

func controlar_input(event):
	pass

func _tiempo_agotado():
	player_movible = true
	var nodo_arbol = get_node("/root/Node")
	var fade = nodo_arbol.get_node("Interfaz/Fade_out_final")
	var fade_animacion = fade.get_node("AnimationPlayer")
	fade_animacion.connect("animation_finished", self, "_animacion_fade_out_finalizada")
	fade_animacion.play("fade_out_final")

func _animacion_fade_out_finalizada(anim_name):
	# Si la animación terminó...
	if anim_name == "fade_out_final":
		# Redirigimos al jugador a los créditos
		get_tree().change_scene("res://Escenas/Niveles/Creditos.tscn")
	
