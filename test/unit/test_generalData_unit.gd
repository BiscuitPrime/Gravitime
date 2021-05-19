extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe GeneralData

var generalData = preload("res://Source/Autoload/Script/GeneralData.gd").new()

#On teste la fonction reset() de GeneralData :
func test_reset():
	generalData.player_hp=5 #On met la GeneralData.player_hp = 5
	generalData.reset()
	assert_eq(generalData.player_hp,10,"Should succeed : le reset remet GeneralData.player_hp à 10")

#On teste la fonction set_player_hp() de GeneralData :
func test_set_player_hp():
	generalData.reset() #On remet la vie du joueur à 0
	generalData.set_player_hp(4)
	assert_eq(generalData.player_hp, 4, "Should succeed : GeneralData.set_player_hp(4) va mettre player_hp=4")

#On teste la fonction get_player_hp() de GeneralData :
func test_get_player_hp():
	generalData.player_hp=7
	var out = generalData.get_player_hp()
	assert_eq(out, 7, "Should succeed : on récupère la valeur de player_hp (qui vaut ici 7)")
