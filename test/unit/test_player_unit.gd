extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Player

var player = preload("res://Source/Actors/Script/Player.gd").new() #On load le script de Player comme nouvelle instance que l'on va tester

#On teste si la méthode save() du joueur fonctionne : (elle doit enregistrer une position)
func test_save():
	player.save()
	assert_eq(null, player.timeposition, "Should fail : timeposition != null (le joueur a enregistré une position)")

#On teste si la méthode skills() de Player ne modifie pas les états is_attacking ou timeconrol_active sans input de l'utilisateur
func test_skills():
	player.skills()
	assert_eq(player.is_attacking,true,"Should fail : sans input de l'utilisateur, player n'utilise pas d'attaque : is_attacking = false")
	assert_eq(player.timecontrol_active,true,"Should fail : sans input de l'utilisateur, player n'utilise pas le rembobinage temporel : timecontrol_active = false")

#On teste la méthode calculate_new_velocity() pour voir si on calcule correctement :
func test_move_velocity():
	var out = player.calculate_move_velocity(Vector2(10,10), Vector2(1,-1), Vector2(800,1600), false)
	assert_eq(out, Vector2(800.0,-1600), "Should suceed : out.x = (800*1) et out.y=-1*1600 car direction.y=-1")
