extends Sprite

export(String) var escena_target

func _ready():
	set_process(true)
	pass


func _process(delta):
	self.set_rotation_degrees(self.get_rotation_degrees() + 2)


func _on_Area2D_body_entered(body):
	# Pasamos al jugador al siguiente nivel con una animación
	if body == Global.personaje:
		Global.pasar_al_siguiente_nivel(escena_target)
	
	# Le indicamos a nuestro save data que ya finalizamos el nivel
	# y que lo guarde en el archivo .txt
	var nodo_arbol_nivel = get_node("/root/Node").nivel
	
	# Leemos la información actual en el archivo .txt de la partida
	var datos_a_guardar = SavingSystem.leer_datos()
	
	print(typeof(nodo_arbol_nivel))
	
	# Si el área en el que colisiono el jugador pertenece a uno de
	# los dos portales que existen (el de nivel y el de mundo)
	# que guarde los datos
	var portal_grupo = self.get_node("../")
	if portal_grupo.is_in_group("meta_portal"):
		print("Si entró")
		print(portal_grupo.get_groups())
		# Validamos el nivel que fué realizado para que posteriormente lo guarde
		# ~ Arrival ~
		if nodo_arbol_nivel == "1": datos_a_guardar.niveles.nivel_2 = true
		if nodo_arbol_nivel == "2": datos_a_guardar.niveles.nivel_3 = true
		if nodo_arbol_nivel == "3": datos_a_guardar.niveles.nivel_4 = true
		if nodo_arbol_nivel == "4": datos_a_guardar.niveles.nivel_5 = true
		if nodo_arbol_nivel == "5": datos_a_guardar.niveles.nivel_6 = true
		if nodo_arbol_nivel == "6": datos_a_guardar.niveles.nivel_7 = true
		if nodo_arbol_nivel == "7": datos_a_guardar.niveles.nivel_8 = true
		if nodo_arbol_nivel == "8": datos_a_guardar.niveles.nivel_9 = true
		if nodo_arbol_nivel == "9": datos_a_guardar.niveles.nivel_10 = true
		if nodo_arbol_nivel == "10": datos_a_guardar.niveles.final_arrival = true
		
		# ~ Wisdom ~
		if nodo_arbol_nivel == "11": datos_a_guardar.niveles.nivel_12 = true
		if nodo_arbol_nivel == "12": datos_a_guardar.niveles.nivel_13 = true
		if nodo_arbol_nivel == "13": datos_a_guardar.niveles.nivel_14 = true
		if nodo_arbol_nivel == "14": datos_a_guardar.niveles.nivel_15 = true
		if nodo_arbol_nivel == "15": datos_a_guardar.niveles.nivel_16 = true
		if nodo_arbol_nivel == "16": datos_a_guardar.niveles.nivel_17 = true
		if nodo_arbol_nivel == "17": datos_a_guardar.niveles.nivel_18 = true
		if nodo_arbol_nivel == "18": datos_a_guardar.niveles.nivel_19 = true
		if nodo_arbol_nivel == "19": datos_a_guardar.niveles.nivel_20 = true
		if nodo_arbol_nivel == "20": datos_a_guardar.niveles.final_wisdom = true
		
		# ~ Madness ~
		if nodo_arbol_nivel == "21": datos_a_guardar.niveles.nivel_22 = true
		if nodo_arbol_nivel == "22": datos_a_guardar.niveles.nivel_23 = true
		if nodo_arbol_nivel == "23": datos_a_guardar.niveles.nivel_24 = true
		if nodo_arbol_nivel == "24": datos_a_guardar.niveles.nivel_25 = true
		if nodo_arbol_nivel == "25": datos_a_guardar.niveles.nivel_26 = true
		if nodo_arbol_nivel == "26": datos_a_guardar.niveles.nivel_27 = true
		if nodo_arbol_nivel == "27": datos_a_guardar.niveles.nivel_28 = true
		if nodo_arbol_nivel == "28": datos_a_guardar.niveles.nivel_29 = true
		if nodo_arbol_nivel == "29": datos_a_guardar.niveles.nivel_30 = true
		if nodo_arbol_nivel == "30": datos_a_guardar.niveles.final_madness = true
		
		# Le pasamos el JSON para que guarde los datos
		SavingSystem.guardar_datos(datos_a_guardar)
	else:
		print("El area pertenece a otro grupo")
		portal_grupo.get_groups()
	
