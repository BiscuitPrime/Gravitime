extends "res://addons/gut/test.gd"
#Ce script teste les différentes intéractions de la classe Enemy avec d'autres classes


var gravity_field = preload("res://Source/Gravity/Script/GravityField.gd").new()#On load le script du gravity_field
var actor = preload("res://Source/Actors/Script/Actor.gd").new()
var enemy = preload("res://Source/Actors/Script/Enemy.gd").new()

#On teste si Enemy détecte bien les Gravity fields ou non :
func test_on_PhysicalHitbox_area_entered():
	enemy._on_PhysicalHitbox_area_entered(null) #On teste d'abord avec aucun champ
	assert_eq(enemy.is_in_gravity_field,false, "Should succeed : player n'est pas dans un champs de gravité i.e. is_in_gravity_field=false")
	enemy._on_PhysicalHitbox_area_entered(gravity_field) #On teste avec un champ
	assert_eq(enemy.is_in_gravity_field,true, "Should succeed : player est dans un champs de gravité i.e. is_in_gravity_field=true")

func test_on_PhysicalHitbox_area_exited():
	enemy._on_PhysicalHitbox_area_exited(gravity_field) #On teste avec un champ
	assert_eq(enemy.is_in_gravity_field,false, "Should succeed : player sort du champs de gravité i.e. is_in_gravity_field=true")

