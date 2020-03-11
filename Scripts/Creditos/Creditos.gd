extends Control

var tiempo_transcurrido = 0
export(String) var escena_a_redirigir
var primer_timer_iniciado = false

func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_creditos_terminados")
	set_process(true)


func _creditos_terminados(_anim_name):
	if !primer_timer_iniciado:
		var timer = Timer.new()
		add_child(timer)
		timer.connect("timeout", self, "_tiempo_agotado", [timer])
		timer.wait_time = 3.0
		timer.start()
		primer_timer_iniciado = true
		var musica = Global.obtener_audio_global()
		var tween_musica = Tween.new()
		add_child(tween_musica)
		tween_musica.interpolate_property(musica, "volume_db", musica.get_volume_db(), -80, 3.0, Tween.TRANS_LINEAR, Tween.EASE_OUT, 3.0)
		tween_musica.start()


func _tiempo_agotado(timer):
	timer.stop()
	var timer_fade = Timer.new()
	add_child(timer_fade)
	timer_fade.connect("timeout", self, "_mostrar_fade", [timer_fade])
	timer_fade.wait_time = 2.0
	timer_fade.start()
	
	$AnimationPlayer.play("fade_in")
	$AnimationPlayer.connect("animation_finished", self, "_animacion_terminada", [timer_fade])

func _animacion_terminada(_anim_name, timer_fade):
	timer_fade.stop()
	return get_tree().change_scene(escena_a_redirigir)
