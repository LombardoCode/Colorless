extends ColorRect

onready var animacion = get_node("../../CanvasLayer2/VolverAlMenu/AnimationPlayer")
onready var btn_volver = get_node("../../CanvasLayer2/VolverAlMenu")

func _ready():
	Global.btn_volver = self
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		if animacion != null:
			animacion.connect("animation_finished", self, "_animacion_terminada")
			animacion.play("aparecer")
			self.get_node("../../CanvasLayer2/VolverAlMenu").visible = true
		self.set_visible(false)
	pass


func _animacion_terminada(anim_name):
	if anim_name == "aparecer":
		btn_volver.visible = true
	pass
