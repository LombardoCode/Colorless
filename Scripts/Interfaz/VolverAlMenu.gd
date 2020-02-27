extends TextureButton

export(String) var escena_target

func _ready():
	$Timer.connect("timeout", self, "_tiempo_agotado",  [escena_target])
	self.connect("button_up", self, "_cambiar_escena")

func _cambiar_escena():
	if get_tree().get_root().get_node("Node/Interfaz/Fade"):
		get_tree().get_root().get_node("Node/Interfaz/Fade").set_visible(true)
		get_tree().get_root().get_node("Node/Interfaz/Fade/AnimationPlayer").play("fade_in")
	$Timer.start()

func _tiempo_agotado(escena_target):
	get_tree().change_scene(escena_target)
