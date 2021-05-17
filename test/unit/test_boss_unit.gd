extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Boss

var boss = preload("res://Source/Actors/Script/Boss.gd").new() #On load le boss

#On teste fonction hit :
func test_hit():
	boss.boss_hit(1)
	assert_eq(boss.boss_hp,2,"Should succeed : le boss prends un dégât donc boss_hp = 3 - 1 = 2")
