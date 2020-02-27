extends ColorRect

var tiempo = 1.0
var tipo_tween = Tween.TRANS_SINE
var tipo_ease = Tween.EASE_IN

func _ready():
	Global.animacion_flash = self 
	pass

func tween_completado(object, key):
	Global.personaje.celebrando = false
	pass

func flashear():
	#print("Flashing...")
	var tween = Tween.new()
	tween.set_name("Tween_flash")
	add_child(tween)
	tween.connect("tween_completed", self, "tween_completado")
	tween.interpolate_property(self, "modulate:a", 1.0, 0.0, tiempo, tipo_ease, tipo_ease)
	tween.start()

