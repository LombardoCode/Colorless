extends Camera2D

onready var screen_size = get_viewport().get_visible_rect().size

func _ready():
	# Hacemos que el collision shape de la camara sea del tamaño del tamaño de pantalla de la ventana
	$Area2D/CollisionShape2D.get_shape().set_extents(screen_size)
	set_process(true)

func _process(_delta):
	# Si tenemos un personaje dentro del nivel...
	if Global.personaje != null:
		var player_node = Global.personaje
		var player_node_pos = player_node.global_position
		var coord_x = floor(player_node_pos.x / screen_size.x)
		var coord_y = floor(player_node_pos.y / screen_size.y)
		var pos_x = coord_x * screen_size.x
		var pos_y = coord_y * screen_size.y
		if coord_y == 0:
			$Tween.interpolate_property(self, "position", self.global_position, Vector2(pos_x, pos_y), 0.3, Tween.TRANS_QUART, Tween.EASE_OUT)
			$Tween.start()

