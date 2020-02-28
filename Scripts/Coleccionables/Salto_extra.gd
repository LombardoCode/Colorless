extends Sprite

var funcionalidad = true

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.get_name() == "Personaje":
		if funcionalidad:
			#Global.personaje.puede_saltar = true
			#body.puede_saltar = true
			#Global.personaje.doble_salto = true
			body.doble_salto = true
			#body.saltando_doble = false
			funcionalidad = false
		$Tween.interpolate_property(self, "modulate:a", 1, 0, 1.0, Tween.TRANS_QUINT, Tween.EASE_OUT, 0)
		$Tween.interpolate_property(self, "scale", self.get_scale(), Vector2(0, 0), 1.0, Tween.TRANS_QUINT, Tween.EASE_OUT, 0)
		$Tween.start()
		
		# Creamos un timer para que dentro de una determinada cantidad de segundos vuelva a aparecer nuestro item de salto extra
		var timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(2)
		timer.connect("timeout", self, "_timeout")
		add_child(timer)
		timer.start()
	


func _timeout():
	$Tween.interpolate_property(self, "modulate:a", 0, 1, 1.0, Tween.TRANS_QUINT, Tween.EASE_OUT, 0)
	$Tween.interpolate_property(self, "scale", self.get_scale(), Vector2(2.8, 2.8), 1.0, Tween.TRANS_QUINT, Tween.EASE_OUT, 0)
	$Tween.start()
	funcionalidad = true
