extends StaticBody2D

var desplazamiento = 20
var tipo_tween = Tween.TRANS_SINE
var tipo_ease = Tween.EASE_IN_OUT
var tiempo_tween = 1.5
var posicion_inicial
export(float) var retardo

var portal_mundo = preload("res://Escenas/Items/Meta/Portal_mundo.tscn")

var escenas_target_lista = {
	"hacia_wisdom" : "res://Escenas/Niveles/Nivel11.tscn",
	"hacia_madness" : "res://Escenas/Niveles/Nivel21.tscn",
	"hacia_final" : "res://Escenas/Niveles/Escena_final.tscn"
}


func _ready():
	# Conectamos el Area2D de la piel recolectable
	$Area2D.connect("body_entered", self, "entro_player")
	
	# Obtenemos la posición inicial para después manipular el Tween
	posicion_inicial = self.get_position()
	
	# Conectamos, interpolamos e iniciamos el Tween
	$Tween.connect("tween_completed", self, "tween_completado")
	$Tween.interpolate_property(self, "position", self.get_position(), self.get_position() -Vector2(0, desplazamiento), tiempo_tween, tipo_tween, tipo_ease, retardo)
	$Tween.start()
	
	set_process(true)
	


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
		
		# Obtenemos el nodo árbol
		var nodo_arbol = get_node("/root/Node")
		# Instanciamos el portal (solo si estamos en el mundo 1 (arrival) o en el mundo 2 (wisdom
		if !nodo_arbol.is_in_group("madness"):
			var portal_mundo_nuevo = portal_mundo.instance()
			get_node("/root/Node").add_child(portal_mundo_nuevo)
			portal_mundo_nuevo.position = Vector2(1100, 500)
			if portal_mundo_nuevo.has_node("Meta"):
				if nodo_arbol.is_in_group("arrival"):
					# Determinamos el primer nivel del mundo mundo
					portal_mundo_nuevo.get_node("Meta").escena_target = escenas_target_lista.hacia_wisdom
					
					# Le cambiamos la piel al jugador
					var datos_nuevos = SavingSystem.leer_datos()
					datos_nuevos.pieles.piel1 = true
					SavingSystem.guardar_datos(datos_nuevos)
					
				if nodo_arbol.is_in_group("wisdom"):
					# Determinamos el primer nivel del mundo mundo
					portal_mundo_nuevo.get_node("Meta").escena_target = escenas_target_lista.hacia_madness
					
					# Le cambiamos la piel al jugador
					var datos_nuevos = SavingSystem.leer_datos()
					datos_nuevos.pieles.piel2 = true
					SavingSystem.guardar_datos(datos_nuevos)
					
#				if nodo_arbol.is_in_group("madness"):
					# Determinamos la escena final del videojuego
#					portal_mundo_nuevo.get_node("Meta").escena_target = escenas_target_lista.hacia_final
		else: # Si se trata del mundo "Madness!"
			# Le cambiamos la piel al jugador
			var datos_nuevos = SavingSystem.leer_datos()
			datos_nuevos.pieles.piel3 = true
			SavingSystem.guardar_datos(datos_nuevos)
			
