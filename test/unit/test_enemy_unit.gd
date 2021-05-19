extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Enemy

var enemy = preload("res://Source/Actors/Script/Enemy.gd").new() #On load le boss
var enemy_scene = preload("res://Source/Actors/Scene/Enemy.tscn").instance()
var detector_right = enemy_scene.get_node("DetectorRight")
var detector_left = enemy_scene.get_node("DetectorLeft")
var detector_platright = enemy_scene.get_node("DetectorPlatformRight")
var detector_platleft = enemy_scene.get_node("DetectorPlatformLeft")
var sprite_ = enemy_scene.get_node("enemy")

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
	assert_eq(enemy.position,Vector2(45,56), "Should succeed : l'enemy, placé en (3,3) revient à sa position timeposition=(45,56) donc position=(45,56)")

#On teste si l'enemy voit sa vélocité qui change via calculate_new_velocity():
func test_calculate_new_velocity():
	enemy.DetectorLeft=detector_left
	enemy.DetectorRight=detector_right
	enemy.DetectorPlatLeft=detector_platleft
	enemy.DetectorPlatRight=detector_platright
	enemy.sprite=sprite_
	enemy.position=Vector2(0,0)
	var new_velocity=enemy.calculate_new_velocity(Vector2(2,2))
	assert_eq(new_velocity, Vector2(-800,2), "Should succeed : la vélocité initiale (2,2) est transformée par calculate_new_velocity(velocity) et devient (-800,2)")
