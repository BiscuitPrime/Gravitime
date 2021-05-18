extends "res://addons/gut/test.gd"
#Ce script teste les différentes intéractions de la classe Box avec d'autres classes

var box = preload("res://Source/Entities/Script/Box.gd").new() #On load le script de Box comme nouvelle instance que l'on va tester
var gravity_field = preload("res://Source/Gravity/Script/GravityField.gd").new()#On load le script du gravity_field


#On teste si Box détecte bien les Gravity fields ou non :
func test_on_PhysicalHitbox_area_entered():
	box.nb_champs=0
	box._on_PhysicalHitbox_area_entered(null) #On teste d'abord avec aucun champ
	assert_eq(box.nb_champs,1, "Should fail : box n'est pas dans un champs de gravité i.e. nb_champs=0")
	box._on_PhysicalHitbox_area_entered(gravity_field) #On teste avec un champ
	assert_eq(box.nb_champs,1, "Should succeed : box est dans un champs de gravité i.e. nb_champs=1")

func test_on_PhysicalHitbox_area_exited():
	box.nb_champs=1
	box._on_PhysicalHitbox_area_exited(gravity_field) #On teste avec un champ
	assert_eq(box.nb_champs,0, "Should succeed : box sort du champs de gravité i.e. nb_champs=0")
