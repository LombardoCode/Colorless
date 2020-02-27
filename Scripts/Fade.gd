extends ColorRect

func _ready():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fade_out":
		self.set_visible(false)
#	elif anim_name == "fade_in":
#		print("listo")
	
