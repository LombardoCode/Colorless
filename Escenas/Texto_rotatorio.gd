extends RichTextLabel

var tween_valores = [-2, 2]
var tween_segundos = 2

func _ready():
	var size = self.get_size()
	var pivot = Vector2(size.x / 2, size.y / 2)
	self.set_pivot_offset(pivot)
	$Tween.interpolate_property(self, "rect_rotation", self.get_rotation_degrees(), tween_valores[1], tween_segundos, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
	$Tween.start()

func _on_Tween_tween_completed(_object, _key):
	if self.get_rotation_degrees() == tween_valores[1]:
		$Tween.interpolate_property(self, "rect_rotation", self.get_rotation_degrees(), tween_valores[0], tween_segundos, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
		$Tween.start()
	elif self.get_rotation_degrees() == tween_valores[0]:
		$Tween.interpolate_property(self, "rect_rotation", self.get_rotation_degrees(), tween_valores[1], tween_segundos, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0)
		$Tween.start()
