extends Node2D
#Ce script est utilisé par la scène auto-loadé (toujours active) qui va controler le Temps et sa manipulation dans le jeu

var player_inputs := [] setget set_player_inputs, get_player_inputs #Cette variable globale contient une liste d'inputs du joueur utilisés par le clone temporel
var clone_exists := false setget set_clone_exists, get_clone_exists #Cette variable indique si un clone temporel existe ou non

#Cette fonction est appelée par la scène Player lorsque l'utilisateur appuie sur F
func timereset():
	player_inputs=[]
	for node in get_tree().get_nodes_in_group("timecontrol") : #On appelle la fonction save() de chaque élément qui subit les fluctuations temporelles (et qui est dans le groupe attitré "timecontrol")
		node.save()
	$TimeResetTimer.start() #On lance le timer qui "délimite" la frange temporelle
	pass

#Cette fonction est appelée lorsque le TimeResetTimer se termine (fin de la frange temporelle)
#On "rembobine" alors, en remettant les éléments affectés par le temps à leurs positions avant le TimeReset
func _on_TimeResetTimer_timeout() -> void:
	for node in get_tree().get_nodes_in_group("timecontrol") : #On appelle la fonction timeReset() de chaque élément qui subit les fluctuations temporelles (et qui est dans le groupe attitré "timecontrol")
		node.timeReset()
	pass # Replace with function body.

#Cette fonction permet d'enregistrer à la suite les inputs du joueur (un input par frame, null si pas d'inputs) 
func set_player_inputs(value):
	player_inputs.append(value)
	pass

#Cette fonction renvoie la liste d'inputs du joueur
func get_player_inputs():
	return player_inputs

#Cette fonction permet d'enregistrer à la suite les inputs du joueur (un input par frame, null si pas d'inputs) 
func set_clone_exists(value):
	clone_exists=value
	pass

#Cette fonction renvoie la liste d'inputs du joueur
func get_clone_exists():
	return clone_exists
