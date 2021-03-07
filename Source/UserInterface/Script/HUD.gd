extends Control
#Ce script est utilisé par le HUD pour montrer le nombres de points de vie du joueur

#Cette fonction actualise les points de vie du joueur
func _process(delta):
	$CenterContainer/HP_Label.text = "HP = "+String(GeneralData.player_hp)
