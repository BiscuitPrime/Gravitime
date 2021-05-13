extends Node2D
#Ce script est utilisé par la scène auto-loadé (toujours active) qui va controler le Temps et sa manipulation dans le jeu

var player_inputs := [] setget set_player_inputs, get_player_inputs #Cette variable globale contient une liste d'inputs du joueur utilisés par le clone temporel
var player_facing = true setget set_player_facing, get_player_facing #Cette variable va contenir la direction d'orientation du joueur

#Cette fonction est appelée par la scène Player lorsque l'utilisateur appuie sur F
func timereset():
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

#Cette fonction enregistre la direction (facing) du joueur
func set_player_facing(bool_value):
	player_facing=bool_value
	pass

#Cette fonction renvoie la direction (facing) du joueur
func get_player_facing():
	return player_facing