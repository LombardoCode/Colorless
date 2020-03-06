extends Node2D

var tween
var escala = [Vector2(0, 0), Vector2(3, 3)]
var duracion = 4.0
var tipo_tween = Tween.TRANS_ELASTIC
var tipo_ease = Tween.EASE_OUT
var retardo = 0.5

func _ready():
	$Meta/Area2D.connect("body_entered", self, "_entro_body")
	self.hide()
	tween = Tween.new()
	add_child(tween)
	tween.connect("tween_started", self, "_tween_started")
	tween.interpolate_property(self, "scale", escala[0], escala[1], duracion, tipo_tween, tipo_ease, retardo)
	tween.start()
	

func _tween_started(object, key):
	self.show()


func _entro_body(body):
	if body == Global.personaje:
		# Le indicamos a nuestro save data que ya finalizamos el nivel
		# y que lo guarde en el archivo .txt
		var nodo_arbol_nivel = get_node("/root/Node").nivel
		
		# Leemos la información actual en el archivo .txt de la partida
		var datos_a_guardar = SavingSystem.leer_datos()
		
		# Verificamos en qué nivel final está el jugador para deshabilitarle
		# la siguiente escena
		if nodo_arbol_nivel == "final_arrival": datos_a_guardar.niveles.nivel_11 = true
		if nodo_arbol_nivel == "final_wisdom": datos_a_guardar.niveles.nivel_21 = true
		if nodo_arbol_nivel == "final_wisdom": datos_a_guardar.escena_final = true
		
		# Le pasamos el JSON para que guarde los datos
		SavingSystem.guardar_datos(datos_a_guardar)
