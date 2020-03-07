extends RichTextLabel

var index = 0

var dialogos = [
	"En una noche tan pacifica y tan tranquila como la de hoy... nuestro héroe, Cuby, se encuentra descansando.",
	"Parece que ha sido un largo día para nuestro amigo.",
	"que cantaba",
	"el rey David"
]


var cantidad_dialogos


func _ready():
	cantidad_dialogos = dialogos.size()
	set_process(true)

func _process(delta):
	self.text = dialogos[index]
