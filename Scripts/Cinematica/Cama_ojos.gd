extends Sprite

var tween
var posiciones = [-136, -140]
var tipo_tween = Tween.TRANS_SINE
var tipo_ease = Tween.EASE_IN
var duracion_tween = 1.5
var origen_x = 10

func _ready():
	#self.visible = false
	tween = Tween.new()
	add_child(tween)
	tween_abajo()
	set_process(true)

func _process(delta):
	# Lo posicionamos en el centro de la pantalla
	self.position = Vector2(Global.obtener_tamanio_ventana().x / 2, Global.obtener_tamanio_ventana().y / 2)

func tween_abajo():
	if tween.is_connected("tween_completed", self, "_tween_completado_2"):
		tween.disconnect("tween_completed", self, "_tween_completado_2")
	tween.connect("tween_completed", self, "_tween_completado")
	tween.interpolate_property($Ojos, "position", Vector2(origen_x, posiciones[0]), Vector2(origen_x, posiciones[1]), duracion_tween, tipo_tween, tipo_ease)
	tween.start()

func _tween_completado(object, key):
	if tween.is_connected("tween_completed", self, "_tween_completado"):
		tween.disconnect("tween_completed", self, "_tween_completado")
	tween.connect("tween_completed", self, "_tween_completado_2")
	tween.interpolate_property($Ojos, "position", Vector2(origen_x, posiciones[1]), Vector2(origen_x, posiciones[0]), duracion_tween, tipo_tween, tipo_ease)
	tween.start()

func _tween_completado_2(object, key):
	tween_abajo()

