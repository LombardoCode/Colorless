extends RichTextLabel

var index = 0

var dialogos = [
	"En una noche tan pacifica y tan tranquila como la de hoy... nuestro héroe, Cuby, se encuentra descansando.",
	"Parece que ha sido un largo día para nuestro amigo.",
	"Todo parecía indicar una noche tranquila, hasta que derrepente...",
	"¡OH NO!\n¡Una entidad maligna quiere dañar a Cuby!",
	"¡Se acaba de robar las pieles de Cuby!\n¡Seguramente la entidad maligna las esconderá!\n¡Hay que avisarle a Cuby!"
]


var cantidad_dialogos


func _ready():
	cantidad_dialogos = dialogos.size()
	set_process(true)

func _process(delta):
	self.text = dialogos[index]
