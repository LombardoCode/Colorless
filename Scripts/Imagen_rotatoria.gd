extends Sprite

var tween_valores = [-2, 2]
var tween_segundos = 1

func _ready():
	$Tween.connect("tween_completed", self, "_on_Tween_tween_completed")
	$Tween.interpolate_property(self, "rotation_degrees", self.get_rotation_degrees(), tween_valores[1], tween_segundos, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
	$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	if self.get_rotation_degrees() == tween_valores[1]:
		$Tween.interpolate_property(self, "rotation_degrees", self.get_rotation_degrees(), tween_valores[0], tween_segundos, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
		$Tween.start()
	elif self.get_rotation_degrees() == tween_valores[0]:
		$Tween.interpolate_property(self, "rotation_degrees", self.get_rotation_degrees(), tween_valores[1], tween_segundos, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
		$Tween.start()
