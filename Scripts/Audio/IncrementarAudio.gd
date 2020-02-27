extends AudioStreamPlayer

func _ready():
	set_process(true)

func _process(_delta):
	var personaje_coordenadas = Global.get_coordenadas()
	
	if personaje_coordenadas == Vector2(2, 0):
		$Tween.interpolate_property(self, "volume_db", self.get_volume_db(), -10, 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
	else:
		$Tween.interpolate_property(self, "volume_db", self.get_volume_db(), -80, 1.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
	pass
