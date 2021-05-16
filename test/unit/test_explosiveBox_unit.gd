extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe ExplosiveBox

var explosiveBox = preload("res://Source/Entities/Script/Box.gd").new() #On load le script de ExplosiveBox comme nouvelle instance que l'on va tester

#On teste si la méthode save() de la boîte fonctionne : (elle doit enregistrer une position)
func test_save():
	explosiveBox.position = Vector2(45,56)
	explosiveBox.save()
	assert_eq(explosiveBox.timeposition, Vector2(0,0), "Should fail : timeposition != null (la boîte a enregistré une position)")
