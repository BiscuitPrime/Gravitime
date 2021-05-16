extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Projectile

var projectile = preload("res://Source/Entities/Script/Projectile.gd").new() #On load le script de Projectile comme nouvelle instance que l'on va tester

#On teste si la méthode _ready() du projectile fonctionne : (elle doit s'assigner au groupe "projectile")
func test_ready():
	projectile._ready()
	assert_eq(false, projectile.is_in_group("projectile"), "Should fail : projectile devrait être dans le groupe \"projectile\"")
