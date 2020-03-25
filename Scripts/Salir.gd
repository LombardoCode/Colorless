extends Control

func _ready():
	self.connect("button_up", self, "_presionado")
	self.connect("mouse_entered", self, "_hover")
	self.connect("mouse_exited", self, "_exited")
	set_process(true)

func _process(_delta):
	var tamanio_pantalla = OS.get_window_size()
	var tamanio_obj = self.rect_size
	self.set_pivot_offset(Vector2(tamanio_obj.x / 2, tamanio_obj.y / 2))

func _presionado():
	get_tree().quit()

func _hover():
	self.get_node("Tween").interpolate_property(self, "rect_scale", self.get_scale(), Vector2(1.2, 1.2), 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	self.get_node("Tween").start()
	
func _exited():
	self.get_node("Tween").interpolate_property(self, "rect_scale", self.get_scale(), Vector2(1, 1), 0.4, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	self.get_node("Tween").start()
	
