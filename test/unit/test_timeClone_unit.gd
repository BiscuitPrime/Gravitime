extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe TimeClone

var timeclone = preload("res://Source/Actors/Script/TimeClone.gd").new() #On load le script de Player comme nouvelle instance que l'on va tester

#On teste si la méthode skills() de Player ne modifie pas les états is_attacking ou timeconrol_active sans input de l'utilisateur
func test_jump():
	timeclone.speed=Vector2(800,1600)
	timeclone.position=Vector2(0,0)
	timeclone.jump()
	assert_eq(timeclone.position,Vector2(0,0),"Should fail : position initiale (0,0); comme le clone saute, sa position change")

#On teste la méthode calculate_new_velocity() pour voir si on calcule correctement :
func test_move_velocity():
	var out = timeclone.calculate_move_velocity(Vector2(10,10), Vector2(1,-1), Vector2(800,1600), false)
	assert_eq(out, Vector2(800.0,-1600), "Should succeed : out.x = (800*1) et out.y=-1*1600 car direction.y=-1")

#On teste la méthode get_direction():
func test_get_direction():
	timeclone.input="move_right"
	var out = timeclone.get_direction()
	assert_eq(out.x, 1.0, "Should succeed : h_direction=1.0")
