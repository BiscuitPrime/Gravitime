extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe GarvaityField

var field = preload("res://Source/Gravity/Script/GravityField.gd").new() #On load le script de GravityField comme nouvelle instance que l'on va tester
var field_object = preload("res://Source/Gravity/Scene/GravityField.tscn").instance() #on load une instance pour récupérer et faire des test sur ses sprites de flèches
var fleches = field_object.get_node("Sprite").get_children()

func test_ready():
	field._ready()
	assert_eq(field.gravity_field, Vector2(0,1)*field.norm_default, "Should succeed : le vecteur champs de gravité initial doit bien être orienté vers le bas de norme norm_default")
	assert_eq(field.gravity_vec, (field.gravity_field/field.norm_default)*98, "Should succeed : le vecteur gravité pour les RigidBody2D doit être égal à l'expression par défault")

func test_indique_sens_intensite():
	var angle = 70
	var intensite = 29
	var i = 1
	field_object.indique_sens_intensite(angle, intensite)
	for fleche in fleches :
		assert_eq(fleche.rotation, float(angle), "Should succeed : la flèche numéro " + str(i) + " doit avoir le même rotation que angle" )
		assert_eq(fleche.scale, Vector2(0.4 - 0.2*intensite,0.3*intensite), "Should succeed : la flèche numéro " + str(i) + " doit avoir le même scale que l'expression donnée par la fonction")
		i += 1
	
func test_get_actual_gravity():
	field.gravity_field = Vector2(400, 378)
	var grav = field.get_actual_gravity()
	assert_eq(grav, Vector2(400, 378), "Should succeed : la valeur renvoyé doit bien être identique à celle du vedcteur gravité actuel")

	
func test_calculate_gravity():
	field.norm_min = 100
	field.norm_max = 2000
	field.sensibility = 1
	var origin = Vector2(200,200)
	var end = Vector2(1000,200)
	var resultat = field.calculate_gravity(origin, end)
	assert_eq(resultat, Vector2(800,0), "Should succeed : dans ce cas là, on doit obtenir (800,0)")
	assert_eq(field.gravity_vec, (Vector2(800,0)/field.norm_default)*98, "Should succeed : dans ce cas là, on doit obtenir la même expression pour le vecteur appliqué aux RigidBody")
	origin = Vector2(0,0)
	end = Vector2(50,0)
	resultat = field.calculate_gravity(origin, end)
	assert_eq(resultat, Vector2(100,0), "Should succeed : le vecteur renvoyé doit bien être (100,0), car la norme min est de 100")
	assert_eq(field.gravity_vec, (Vector2(100,0)/field.norm_default)*98, "Should succeed : dans ce cas là, on doit obtenir la même expression pour le vecteur appliqué aux RigidBody")
	origin = Vector2(380, 240)
	end = Vector2(380, 3240)
	resultat = field.calculate_gravity(origin, end)
	assert_eq(resultat, Vector2(0,2000), "Should succeed : dans ce cas là, on doit obtenir (0,2000) car la norme max est de 2000")
	assert_eq(field.gravity_vec, (Vector2(0,2000)/field.norm_default)*98, "Should succeed : dans ce cas là, on doit obtenir la même expression pour le vecteur appliqué aux RigidBody")
	origin = Vector2(0,0)
	end = Vector2(500,0)
	field.sensibility = 2
	resultat = field.calculate_gravity(origin, end)
	assert_eq(resultat, Vector2(1000,0), "Should succeed : le resultat doit bien avoir pris en compte le facteur de sensibilité à 2, on doit avoir (1000,0)")
