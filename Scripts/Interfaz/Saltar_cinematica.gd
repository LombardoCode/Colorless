extends Node2D

export(String) var escena_target

var puede_saltarse_cinematica = false
var cinematica_saltada = false
var tween
var duracion_tween = 0.5
var tipo_tween = Tween.TRANS_SINE
var tipo_ease = Tween.EASE_OUT
var retardo_tween = 1.5
var alphas = [Color(1, 1, 1, 0), Color(1, 1, 1, 1)]

onready var fade_in_final = get_node("/root/Node/Interfaz/Fade_in_cinematica")

func _ready():
	self.modulate = alphas[0]
	tween = Tween.new()
	add_child(tween)
	tween.connect("tween_completed", self, "_tween_complteado")
	tween.interpolate_property(self, "modulate", alphas[0], alphas[1], duracion_tween, tipo_tween, tipo_ease, retardo_tween)
	tween.start()
	
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("tecla_s") and puede_saltarse_cinematica:
		if !cinematica_saltada:
			# Decrementamos el sonido de la canción de la cinemática
			if Global.cancion_cinematica != null:
				var musica_cinematica = Global.cancion_cinematica
				var tween = Tween.new()
				add_child(tween)
				tween.interpolate_property(musica_cinematica, "volume_db", musica_cinematica.get_volume_db(), -80, 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
				tween.start()
				
				# Silenciamos la canción global para cuando el jugador ingrese al primer nivel haya un
				# fade-in en la música... el fade-in lo hace el Administrador de niveles
				var audioStreamPlayer = Global.obtener_audio_global()
				audioStreamPlayer.volume_db = -80
			
			if fade_in_final.has_node("AnimationPlayer"):
				var fade_in_final_animacion = fade_in_final.get_node("AnimationPlayer")
				fade_in_final_animacion.play("fade_in_cinematica")
				fade_in_final_animacion.connect("animation_finished", self, "_animacion_terminada")
			cinematica_saltada = true

func _tween_complteado(object, key):
	puede_saltarse_cinematica = true

func _animacion_terminada(_anim_name):
	# Creamos un save fresco
	var datos_partida_frescos = SavingSystem.datos_a_guardar
	
	# Habilitamos el nivel 1 del videojuego
	datos_partida_frescos.niveles.nivel_1 = true
	
	# Guardamos los datos
	SavingSystem.guardar_datos(datos_partida_frescos)
	
	# Redirigmos al usuario a la escena target (redireccionador de niveles)
	return get_tree().change_scene(escena_target)
