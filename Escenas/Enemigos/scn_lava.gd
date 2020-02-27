extends Sprite

onready var tween

func _ready():
	$Area2D.connect("body_entered", self, "_desintegrar_entidad")
	$Area2D.connect("body_exited", self, "_fuera_de_colision")
	

func _desintegrar_entidad(body):
	if body.get_name() == "Personaje":
		print("ME DESINTEGRAN")
		if body.get_node("Tween"):
			# Alentamos la gravedad y reseteamos el motion.y del jugador
			body.motion.y = 0
			body.GRAVEDAD = 0
			
			# Realizamos los tweenings
			var tween = body.get_node("Tween")
			tween.interpolate_property(body, "modulate", get_modulate(), Color(0, 0, 0, 1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			tween.interpolate_property(body, "scale", Vector2(0.5, 0.5), Vector2(0.5, 0.5), 0.3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
			tween.start()
			
			
			
#			var timer_achicar = Timer.new()
#			timer_achicar.set_one_shot(true)
#			timer_achicar.set_wait_time(0.1)
#			timer_achicar.connect("timeout", self, "_achicar_jugador", [body])
#			add_child(timer_achicar)
#			timer_achicar.start()
			
			# Reubicamos al jugador en la escena después de haberse caido a la lava
#			var timer = Timer.new()
#			timer.set_one_shot(true)
#			timer.set_wait_time(1)
#			timer.connect("timeout", self, "_reubicar_jugador", [body])
#			add_child(timer)
#			timer.start()
			

func _fuera_de_colision(body):
	if body.get_name() == "Personaje":
		body.GRAVEDAD = 2000

func _achicar_jugador(body):
	if Global.get_coordenadas() == Vector2(1, 0):
		tween = body.get_node("Tween")
		tween.interpolate_property(body, "modulate:a", 1, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
		tween.start()
		print("achicado")

func _reubicar_jugador(body):
	if Global.get_coordenadas() == Vector2(1, 0):
		body.global_position.x = (Global.get_coordenadas().x * Global.obtener_tamanio_ventana().x) + 100
		body.global_position.y = (Global.get_coordenadas().y * Global.obtener_tamanio_ventana().y) + 500
		body.set_modulate(Color(1, 1, 1, 1))
		tween = body.get_node("Tween")
		tween.interpolate_property(body, "scale", Vector2(0, 0), Vector2(0.5, 0.5), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
		tween.start()
		print("reubicado")
		
		
	
