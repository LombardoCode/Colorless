extends Node

var datos_obtenidos

func _ready():
	# Obtenemos los datos actuales de nuestra partida
	datos_obtenidos = SavingSystem.leer_datos()
	
	# ~ Madness (Tercer mundo de Colorless) ~
	if datos_obtenidos.niveles.final_madness == true:
		return get_tree().change_scene("res://Escenas/Niveles/MadnessSuperado.tscn")
	if datos_obtenidos.niveles.nivel_30 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel30.tscn")
	if datos_obtenidos.niveles.nivel_29 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel29.tscn")
	if datos_obtenidos.niveles.nivel_28 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel28.tscn")
	if datos_obtenidos.niveles.nivel_27 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel27.tscn")
	if datos_obtenidos.niveles.nivel_26 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel26.tscn")
	if datos_obtenidos.niveles.nivel_25 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel25.tscn")
	if datos_obtenidos.niveles.nivel_24 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel24.tscn")
	if datos_obtenidos.niveles.nivel_23 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel23.tscn")
	if datos_obtenidos.niveles.nivel_22 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel22.tscn")
	if datos_obtenidos.niveles.nivel_21 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel21.tscn")
	
	# ~ Wisdom (Segundo mundo de Colorless) ~
	if datos_obtenidos.niveles.final_wisdom == true:
		return get_tree().change_scene("res://Escenas/Niveles/WisdomSuperado.tscn")
	if datos_obtenidos.niveles.nivel_20 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel20.tscn")
	if datos_obtenidos.niveles.nivel_19 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel19.tscn")
	if datos_obtenidos.niveles.nivel_18 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel18.tscn")
	if datos_obtenidos.niveles.nivel_17 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel17.tscn")
	if datos_obtenidos.niveles.nivel_16 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel16.tscn")
	if datos_obtenidos.niveles.nivel_15 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel15.tscn")
	if datos_obtenidos.niveles.nivel_14 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel14.tscn")
	if datos_obtenidos.niveles.nivel_13 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel13.tscn")
	if datos_obtenidos.niveles.nivel_12 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel12.tscn")
	if datos_obtenidos.niveles.nivel_11 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel11.tscn")
		
	# ~ Arrival (Primer mundo de Colorless) ~
	if datos_obtenidos.niveles.final_arrival == true:
		return get_tree().change_scene("res://Escenas/Niveles/ArrivalSuperado.tscn")
	if datos_obtenidos.niveles.nivel_10 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel10.tscn")
	if datos_obtenidos.niveles.nivel_9 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel9.tscn")
	if datos_obtenidos.niveles.nivel_8 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel8.tscn")
	if datos_obtenidos.niveles.nivel_7 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel7.tscn")
	if datos_obtenidos.niveles.nivel_6 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel6.tscn")
	if datos_obtenidos.niveles.nivel_5 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel5.tscn")
	if datos_obtenidos.niveles.nivel_4 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel4.tscn")
	if datos_obtenidos.niveles.nivel_3 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel3.tscn")
	if datos_obtenidos.niveles.nivel_2 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel2.tscn")
	if datos_obtenidos.niveles.nivel_1 == true:
		return get_tree().change_scene("res://Escenas/Niveles/Nivel1.tscn")
