extends Node2D



func _ready():
	set_process(true)

func _process(delta):
	self.set_rotation_degrees(self.get_rotation_degrees() + owner.velocidad_giro)
	
	
