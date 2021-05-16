extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Player

var player = preload("res://Source/Actors/Script/Player.gd").new() #On load le script de Player comme nouvelle instance que l'on va tester
var actor = preload("res://Source/Actors/Script/Actor.gd").new()
var gravity_field = preload("res://Source/Gravity/Script/GravityField.gd").new()

#On teste si la méthode save() du joueur fonctionne : (elle doit enregistrer une position)
func test_save():
	player.save()
	assert_eq(null, player.timeposition, "Should fail : timeposition != null (le joueur a enregistré une position)")

#On teste si la méthode skills() de Player ne modifie pas les états is_attacking ou timeconrol_active sans input de l'utilisateur
func test_skills():
	player.skills()
	assert_eq(player.is_attacking,true,"Should fail : sans input de l'utilisateur, player n'utilise pas d'attaque : is_attacking = false")
	assert_eq(player.timecontrol_active,true,"Should fail : sans input de l'utilisateur, player n'utilise pas le rembobinage temporel : timecontrol_active = false")

func test_on_PhysicalHitbox_area_entered():
	player._on_PhysicalHitbox_area_entered(gravity_field)
	assert_eq(player.is_in_gravity_field,true,"Should succeed")
