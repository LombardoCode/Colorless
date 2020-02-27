extends Node2D

func _ready():
	$Tutorial_1.set_text("¡Bienvenido al tutorial!")
	$Tutorial_2.set_text("¡El día de hoy aprenderemos habilidades básicas!")
	
	$Salto_1.set_text("Salto")
	$Salto_2.set_text("¡Presiona [W] para saltar!")
	
	$Saltos_prolongados_1.set_text("Mhmm...")
	$Saltos_prolongados_2.set_text("Este lugar tiene muchos obstáculos...")
	
	$PowerUps_1.set_text("Power-Up de salto")
	$PowerUps_2.set_text("Tienes un doble salto en el aire al tocar cada gema")
	
	$Correr_1.set_text("¡Hora de correr!")
	$Correr_2.set_text("¡Presiona <Shift> mientras caminas para correr!")
	
	$PonteAPrueba_1.set_text("¡Ponte a prueba!")
	$PonteAPrueba_2.set_text("Veamos que tan bien usas las mecánicas...")
	
	$FinDeLaDemo_1.set_text("¡FIN DE LA DEMO!")
	$FinDeLaDemo_2.set_text("¡Gracias por jugar al prototipo de Colorless!")
