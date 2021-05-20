extends "res://addons/gut/test.gd"
#Ce script teste les différentes intéractions de la classe DoorButton avec d'autres classes
#Rien ne peut être testé à cause de l'animationplayer
"""
var button = preload("res://Source/Entities/Script/DoorButton.gd").new() #On load le script de DoorButton comme nouvelle instance que l'on va tester
var box = preload("res://Source/Entities/Script/Box.gd").new() #On load le script de Box
var explosiveBox = preload("res://Source/Entities/Script/ExplosiveBox.gd").new() #On load le script de ExplosiveBox
var actor = preload("res://Source/Actors/Script/Actor.gd").new()
var enemy = preload("res://Source/Actors/Script/Enemy.gd").new() #On load le script de Enemy
var player = preload("res://Source/Actors/Script/Player.gd").new() #On load le script de Player
var timeClone = preload("res://Source/Actors/Script/TimeClone.gd").new() #On load le script de TimeClone

#On teste si DoorButton détecte bien tous les corps susceptibles d'appuyer sur le bouton ou non :
func test_on_body_entered():
	button.nb_corps=0
	button._on_body_entered(null) #On teste d'abord avec aucun corps
	assert_eq(button.nb_corps,1, "Should fail : button ne détecte aucun corps i.e. nb_corps=0")
	button._on_body_entered(box) #On teste avec une Box
	assert_eq(button.nb_corps,1, "Should succeed : button détecte une boîte i.e. nb_corps=1")
	button._on_body_entered(explosiveBox) #On teste avec une ExplosiveBox
	assert_eq(button.nb_corps,2, "Should succeed : button détecte les deux boîtes i.e. nb_corps=2")
	button._on_body_entered(enemy) #On teste avec un Enemy
	assert_eq(button.nb_corps,3, "Should succeed : button détecte les deux boîtes et un ennemi i.e. nb_corps=3")
	button._on_body_entered(player) #On teste avec un Player
	assert_eq(button.nb_corps,4, "Should succeed : button détecte les deux boîtes, un ennemi et le joueur i.e. nb_corps=4")
	button._on_body_entered(TimeClone) #On teste avec un TimeClone
	assert_eq(button.nb_corps,5, "Should succeed : button détecte les deux boîtes, un ennemi, le joueur et son clone i.e. nb_corps=5")

func test_on_body_exited():
	button.nb_corps=5
	button._on_body_exited(box) #On teste avec une Box
	assert_eq(button.nb_corps,4, "Should succeed : Box n'appuie plus sur DoorButton i.e. nb_corps=4")
	button._on_body_exited(explosiveBox) #On teste avec une ExplosiveBox
	assert_eq(button.nb_corps,3, "Should succeed : ExplosiveBox n'appuie plus sur DoorButton i.e. nb_corps=3")
	button._on_body_exited(enemy) #On teste avec un Enemy
	assert_eq(button.nb_corps,2, "Should succeed : Enemy n'appuie plus sur DoorButton i.e. nb_corps=2")
	button._on_body_exited(player) #On teste avec un Player
	assert_eq(button.nb_corps,1, "Should succeed : Player n'appuie plus sur DoorButton i.e. nb_corps=1")
	button._on_body_exited(timeClone) #On teste avec un Player
	assert_eq(button.nb_corps,0, "Should succeed : TimeClone n'appuie plus sur DoorButton i.e. nb_corps=0")
"""
