extends "res://Scripts/Maquina de estados/MaquinaDeEstados.gd"

func _ready():
	mapa_de_estados = {
		"IDLE" : $IDLE,
		"Moverse" : $Moverse,
		"Correr" : $Correr,
		"Saltar" : $Saltar,
		"Caerse" : $Caerse,
		"Salto_doble" : $Salto_doble,
		"Morir" : $Morir,
		"Celebrando": $Celebrando
		
	}
	activar_estado(true)
	cambiar_estado("IDLE")
	

func cambiar_estado(nuevo_estado):
	.cambiar_estado(nuevo_estado)
