extends Node

var datos_a_guardar = {
	niveles = {
		nivel_1 = false,
		nivel_2 = false,
		nivel_3 = false,
		nivel_4 = false,
		nivel_5 = false,
		nivel_6 = false,
		nivel_7 = false,
		nivel_8 = false,
		nivel_9 = false,
		nivel_10 = false,
		final_arrival = false,
		nivel_11 = false,
		nivel_12 = false,
		nivel_13 = false,
		nivel_14 = false,
		nivel_15 = false,
		nivel_16 = false,
		nivel_17 = false,
		nivel_18 = false,
		nivel_19 = false,
		nivel_20 = false,
		final_wisdom = false,
		nivel_21 = false,
		nivel_22 = false,
		nivel_23 = false,
		nivel_24 = false,
		nivel_25 = false,
		nivel_26 = false,
		nivel_27 = false,
		nivel_28 = false,
		nivel_29 = false,
		nivel_30 = false,
		final_madness = false,
		escena_final = false
	},
	pieles = {
		piel0 = true,
		piel1 = false,
		piel2 = false,
		piel3 = false
	},
	muertes = 0
}


func _ready():
	#guardar_datos()
	leer_datos()

func leer_datos():
	var directorio = Directory.new()
	if !directorio.dir_exists("user://save_folder"):
		directorio.make_dir("user://save_folder")
	else:
		if directorio.file_exists("user://save_folder/save_data.txt"):
			var save = File.new()
			#save.open_encrypted_with_pass("user://save_folder/save_data.txt", File.READ, "Colorless")
			save.open("user://save_folder/save_data.txt", File.READ)
			var todos_los_datos
			var linea
			linea = parse_json(save.get_line())
			if linea != null:
				todos_los_datos = linea
			save.close()
			return todos_los_datos
		else:
			guardar_datos(datos_a_guardar)
			leer_datos()

func guardar_datos(datos_nuevos):
	var directorio = Directory.new()
	if !directorio.dir_exists("user://save_folder"):
		directorio.make_dir("user://save_folder")
	var save = File.new()
	#save.open_encrypted_with_pass("user://save_folder/save_data.txt", File.WRITE, "Colorless")
	save.open("user://save_folder/save_data.txt", File.WRITE)
	
	save.store_line(to_json(datos_nuevos))
	save.close()
	

func existe_directorio():
	var directorio = Directory.new()
	if directorio.dir_exists("user://save_folder"):
		return true
	else:
		return false
	

func existe_archivo_partida():
	var directorio = Directory.new()
	if directorio.file_exists("user://save_folder/save_data.txt"):
		return true
	else:
		return false

func eliminar_partida():
	var directorio = Directory.new()
	if existe_directorio() and existe_archivo_partida():
		directorio.remove("user://save_folder/save_data.txt")
