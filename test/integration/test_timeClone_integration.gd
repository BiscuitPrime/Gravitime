extends "res://addons/gut/test.gd"
#Ce script teste les différentes intéractions de la classe TimeClone avec d'autres classes

var timeclone = preload("res://Source/Actors/Script/TimeClone.gd").new() #On load le script de Player comme nouvelle instance que l'on va tester
var gravity_field = preload("res://Source/Gravity/Script/GravityField.gd").new()#On load le script du gravity_field
var actor = preload("res://Source/Actors/Script/Actor.gd").new()
var timeControl = preload("res://Source/Autoload/Script/TimeControl.gd").new()

func test_die():
	timeControl.set_clone_exists(true)
	timeclone.die()
	assert_eq(timeControl.clone_exists,true,"Should fail : un clone a été détruit, TimeControl.clone_exists = false")
