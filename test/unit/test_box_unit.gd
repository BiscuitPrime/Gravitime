extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Box

var box = preload("res://Source/Entities/Script/Box.gd").new() #On load le script de Box comme nouvelle instance que l'on va tester

#On teste si la méthode save() de la boîte fonctionne : (elle doit enregistrer une position)
func test_save():
	box.save()
	assert_eq(null, box.timeposition, "Should fail : timeposition != null (la boîte a enregistré une position)")
