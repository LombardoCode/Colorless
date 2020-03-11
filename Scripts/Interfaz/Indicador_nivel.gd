extends Control

onready var nodo_interfaz = self.get_parent().get_parent()
onready var numero_de_muertes
onready var label_muertes = $Muertes/Numero_de_muertes
onready var nodo_muertes = $Muertes

func _ready():
	# Le indicamos a Global que somos el contador de muertes
	Global.contador_de_muertes = self
	
	# Dibujamos el nivel en el que estamos
	$Nivel/Texto_nivel.text = nodo_interfaz.nivel
	
	# Dibujamos el número de muertes
	numero_de_muertes = SavingSystem.leer_datos().muertes
	label_muertes.text = str(numero_de_muertes)
	
	# Posición de la etiqueta y elementos relacionados a la muerte del jugador
	if numero_de_muertes >= 0 and numero_de_muertes < 10:
		nodo_muertes.position = Vector2(90, 0)
	elif numero_de_muertes >= 10 and numero_de_muertes < 100:
		nodo_muertes.position = Vector2(80, 0)
	elif numero_de_muertes >= 100 and numero_de_muertes < 1000:
		nodo_muertes.position = Vector2(60, 0)
	elif numero_de_muertes >= 1000 and numero_de_muertes < 10000:
		nodo_muertes.position = Vector2(40, 0)
	elif numero_de_muertes >= 10000 and numero_de_muertes < 100000:
		nodo_muertes.position = Vector2(30, 0)
	else:
		nodo_muertes.position = Vector2(20, 0)

func redibujar_el_numero_de_muertes():
	# Dibujamos el número de muertes
	numero_de_muertes = SavingSystem.leer_datos().muertes
	label_muertes.text = str(numero_de_muertes)
