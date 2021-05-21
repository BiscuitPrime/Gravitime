extends Control
#Ce script est utilisé par le HUD pour montrer la vie du joueur

#Cette fonction actualise la vie
func _process(delta):
	$CenterContainer/HP_Label.text = "HP = "+String(GeneralData.get_player_hp())

