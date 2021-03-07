extends Node
#Ce script est utilisé par la node GeneralData qui est en autoload (i.e. toujours active)
#Ce script permet de conserver la vie du joueur

var player_hp := 10 setget set_player_hp, get_player_hp #Cette variable globale est la vie du joueur

#Cette fonction est appelée lors du reset du jeu (par le bouton retry ou autres méthodes)
#Elle remet à l'état initial la vie du joueur
func reset():
	player_hp= 10
	$AudioStreamPlayer.play() #Permet de relancer la musique (on en a pas pour le moment)

#Cette fonction permet de modifier la valeur de la variable player_hp 
#Elle est appelée par d'autres scripts du programme
func set_player_hp(value: int):
	player_hp=value

#Cette fonction renvoie la valeur de player_hp et permet à d'autres scripts d'obtenir cette valeur
#Elle est appelée par d'autres scripts du programme
func get_player_hp():
	return player_hp

func music_stop():
	$AudioStreamPlayer.stop()
