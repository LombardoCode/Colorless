extends TextureButton

export(String) var escena_target
var disponible = false

func _ready():
	self.connect("button_up", self, "_ir_a_nivel")
	
	# Devolvemos el JSON con los datos de los niveles
	var todos_los_datos = SavingSystem.leer_datos()
	
	# Verificamos si están disponibles o no
	if self.get_name() == "Btn_Nivel1":
		disponible = todos_los_datos.niveles.nivel_1
	if self.get_name() == "Btn_Nivel2":
		disponible = todos_los_datos.niveles.nivel_2
	if self.get_name() == "Btn_Nivel3":
		disponible = todos_los_datos.niveles.nivel_3
	if self.get_name() == "Btn_Nivel4":
		disponible = todos_los_datos.niveles.nivel_4
	if self.get_name() == "Btn_Nivel5":
		disponible = todos_los_datos.niveles.nivel_5
	if self.get_name() == "Btn_Nivel6":
		disponible = todos_los_datos.niveles.nivel_6
	
	# Les cambiamos la opacidad dependiendo si los niveles están disponibles o no
	self.modulate = (Color(1, 1, 1, 0.2) if !disponible else Color(1, 1, 1, 1))
	
func _ir_a_nivel():
	#print(disponible)
	if disponible:
		get_tree().change_scene(escena_target)
	#	print("Ya nos dirigimos al nivel")
