extends Control

export(String) var escena_target

func _ready():
	self.connect("button_up", self, "_presionado")
	self.connect("mouse_entered", self, "_hover")
	self.connect("mouse_exited", self, "_exited")
	$Timer.connect("timeout", self, "_tiempo_agotado", [escena_target])
	set_process(true)

func _process(_delta):
	var tamanio_pantalla = OS.get_window_size()
	self.set_pivot_offset(Vector2(tamanio_pantalla.x / 2, self.rect_size.y / 2))
	

func _presionado():
	get_tree().get_root().get_node("Node/Interfaz/Fade").set_visible(true)
	get_tree().get_root().get_node("Node/Interfaz/Fade/AnimationPlayer").play("fade_in")
	$Timer.start()

func _hover():
	self.get_node("Tween").interpolate_property(self, "rect_scale", self.get_scale(), Vector2(1.2, 1.2), 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	self.get_node("Tween").start()
	
func _exited():
	self.get_node("Tween").interpolate_property(self, "rect_scale", self.get_scale(), Vector2(1, 1), 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	self.get_node("Tween").start()
	
func _tiempo_agotado(escena_target):
	get_tree().change_scene(escena_target)
