extends Sprite

export(String) var escena_target

func _ready():
	set_process(true)
	pass


func _process(delta):
	self.set_rotation_degrees(self.get_rotation_degrees() + 2)


func _on_Area2D_body_entered(body):
	if body == Global.personaje:
		Global.pasar_al_siguiente_nivel(escena_target)
