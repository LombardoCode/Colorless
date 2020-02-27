extends StaticBody2D

var desplazamiento = 20
var tipo_tween = Tween.TRANS_SINE
var tipo_ease = Tween.EASE_IN_OUT
var tiempo_tween = 1.5
var posicion_inicial

func _ready():
	# Conectamos el Area2D de la piel recolectable
	$Area2D.connect("body_entered", self, "entro_player")
	
	# Obtenemos la posición inicial para después manipular el Tween
	posicion_inicial = self.get_position()
	
	# Conectamos, interpolamos e iniciamos el Tween
	$Tween.connect("tween_completed", self, "tween_completado")
	$Tween.interpolate_property(self, "position", self.get_position(), self.get_position() -Vector2(0, desplazamiento), tiempo_tween, tipo_tween, tipo_ease)
	$Tween.start()
	pass

func tween_completado(object, key):
	if self.get_position() == Vector2(posicion_inicial.x, posicion_inicial.y - desplazamiento):
		$Tween.interpolate_property(self, "position", self.get_position(), self.get_position() -Vector2(0, -desplazamiento), tiempo_tween, tipo_tween, tipo_ease)
		$Tween.start()
	if self.get_position() == posicion_inicial:
		$Tween.interpolate_property(self, "position", self.get_position(), self.get_position() -Vector2(0, desplazamiento), tiempo_tween, tipo_tween, tipo_ease)
		$Tween.start()
	pass

func entro_player(body):
	if body.get_name() == "Personaje":
		body.celebrando = true
		self.queue_free()
		Global.animacion_flash.flashear()
	pass
