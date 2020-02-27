extends Node

# ESTADOS
var mapa_de_estados = {}
var estado_actual = null
var activo = false
var label

func _ready():
	label = owner.get_node("Estado")
	for hijo in get_children():
		hijo.connect("terminado", self, "cambiar_estado")
	activar_estado(false)

func _physics_process(delta):
	estado_actual.update(delta)

func _input(event):
	estado_actual.controlar_input(event)

func cambiar_estado(nuevo_estado):
	label.text = nuevo_estado
	print(nuevo_estado)
	if !activo:
		return
	estado_actual = mapa_de_estados[nuevo_estado]
	estado_actual.enter()

func activar_estado(nuevoValor):
	activo = nuevoValor
	set_physics_process(activo)
	set_process_input(activo)
	if !activo:
		estado_actual = null
