extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Enemy

var enemy = preload("res://Source/Actors/Script/Enemy.gd").new() #On load le boss

#On teste si l'ennemi sauvegarde sa position :
func test_save():
	enemy.position=Vector2(45,56)
	enemy.save()
	assert_eq(enemy.timeposition,Vector2(45,56),"Should succeed : l'enemy, placé en (45,56) effectue son save et donc timeposition=Vector2(45,56)")

#On teste si l'enemy revient en timeposition lors du rembobinage temporel
func test_timeReset():
	enemy.position=Vector2(3,3)
	enemy.timeposition=Vector2(45,56)
	enemy.timeReset()
	assert_eq(enemy.position,Vector2(45,56), "Should succeed : l'enemy, placé en (3,3) revient à sa position timeposition=(45,56) donc position=(45,56) != (3,3)")
