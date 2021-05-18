extends "res://addons/gut/test.gd"
#Ce script teste les différentes intéractions de la classe ExplosiveBox avec d'autres classes

var explosiveBox = preload("res://Source/Entities/Script/ExplosiveBox.gd").new() #On load le script de ExplosiveBox comme nouvelle instance que l'on va tester
var gravity_field = preload("res://Source/Gravity/Script/GravityField.gd").new()#On load le script du gravity_field
var boss = preload("res://Source/Actors/Script/Boss.gd").new()#On load le script du boss

#On teste si ExplosiveBox détecte bien les Gravity fields ou non :
func test_on_PhysicalHitbox_area_entered():
	explosiveBox.nb_champs=0
	explosiveBox._on_PhysicalHitbox_area_entered(null) #On teste d'abord avec aucun champ
	assert_eq(explosiveBox.nb_champs, 1, "Should fail : explosiveBox n'est pas dans un champs de gravité i.e. nb_champs=0")
	explosiveBox._on_PhysicalHitbox_area_entered(gravity_field) #On teste avec un champ
	assert_eq(explosiveBox.nb_champs, 1, "Should succeed : explosiveBox est dans un champs de gravité i.e. nb_champs=1")

func test_on_PhysicalHitbox_area_exited():
	explosiveBox.nb_champs=1
	explosiveBox._on_PhysicalHitbox_area_exited(gravity_field) #On teste avec un champ
	assert_eq(explosiveBox.nb_champs, 0, "Should succeed : explosiveBox sort du champs de gravité i.e. nb_champs=0")

#On teste si ExplosiveBox détecte bien le boss:
func test_on_PhysicalHitbox_area_entered_boss():
	explosiveBox._on_PhysicalHitbox_area_entered(boss)
	assert_eq(boss.has_method("boss_hit"), true, "Should succeed: boss est détecté et possède bien une méthode boss_hit")
