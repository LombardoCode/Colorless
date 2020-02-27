extends Node

var datos_a_guardar = {
	niveles = {
		nivel_1 = true,
		nivel_2 = false,
		nivel_3 = true,
		nivel_4 = false,
		nivel_5 = true,
		nivel_6 = false,
		nivel_7 = false,
		nivel_8 = false,
		nivel_9 = false,
		nivel_10 = false
	},
	pieles = {
		piel0 = true,
		piel1 = false,
		piel2 = false,
		piel3 = false
	}
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
			guardar_datos()

func guardar_datos():
	var directorio = Directory.new()
	if !directorio.dir_exists("user://save_folder"):
		directorio.make_dir("user://save_folder")
	var save = File.new()
	#save.open_encrypted_with_pass("user://save_folder/save_data.txt", File.WRITE, "Colorless")
	save.open("user://save_folder/save_data.txt", File.WRITE)
	
	save.store_line(to_json(datos_a_guardar))
	save.close()
