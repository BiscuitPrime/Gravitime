extends Control
#Ce script est utilisé par le HUD pour montrer le temps restant pour le rembobinage temporel

var temps_restant=5 #Indique le temps restant (5 sec)

#Cette fonction actualise le temps restant
func _process(delta):
	if temps_restant == 0:
		queue_free()
	$CenterContainer/Time_Label.text = "Temps restant = "+String(temps_restant)

#Lorsque le temps de rembobinage temporel 
func _on_TimeControlTimer_timeout() -> void:
	temps_restant-=1
	pass # Replace with function body.

