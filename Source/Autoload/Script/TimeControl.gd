extends Node2D
#Ce script est utilisé par la scène auto-loadé (toujours active) qui va controler le Temps et sa manipulation dans le jeu

#Cette fonction est appelée par la scène Player lorsque l'utilisateur appuie sur F
func timereset():
	for node in get_tree().get_nodes_in_group("timecontrol") : #On appelle la fonction save() de chaque élément qui subit les fluctuations temporelles
		node.save()
	$TimeResetTimer.start() #On lance le timer qui "délimite" la frange temporelle
	print("ZA WARUDO !")
	pass

#Cette fonction est appelée lorsque le TimeResetTimer se termine (fin de la frange temporelle)
#On "rembobine" alors, en remettant les éléments affectés par le temps à leurs positions avant le TimeReset
func _on_TimeResetTimer_timeout() -> void:
	for node in get_tree().get_nodes_in_group("timecontrol") :
		node.timeReset()
	print("reset !!")
	pass # Replace with function body.
