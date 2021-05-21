extends "res://addons/gut/test.gd"
#Ce script teste les différentes intéractions de la classe TimeClone avec d'autres classes

var timeclone = preload("res://Source/Actors/Script/TimeClone.gd").new() #On load le script de Player comme nouvelle instance que l'on va tester
var gravity_field = preload("res://Source/Gravity/Script/GravityField.gd").new()#On load le script du gravity_field
var actor = preload("res://Source/Actors/Script/Actor.gd").new()
var timeControl = preload("res://Source/Autoload/Script/TimeControl.gd").new()
var enemy = preload("res://Source/Actors/Script/Enemy.gd").new()

##On teste si TimeClone détecte bien les Gravity fields ou non :
func test_on_PhysicalHitbox_area_entered():
	timeclone._on_PhysicalHitbox_area_entered(null)
	assert_eq(timeclone.is_in_gravity_field,false, "Should succeed : player n'est pas dans un champs de gravité i.e. is_in_gravity_field=false")
	timeclone._on_PhysicalHitbox_area_entered(gravity_field) #On teste avec un champ
	assert_eq(timeclone.is_in_gravity_field,true, "Should succeed : player est dans un champs de gravité i.e. is_in_gravity_field=true")

func test_on_PhysicalHitbox_area_exited():
	timeclone._on_PhysicalHitbox_area_exited(gravity_field)
	assert_eq(timeclone.is_in_gravity_field,false, "Should succeed : player sort du champs de gravité i.e. is_in_gravity_field=true")
