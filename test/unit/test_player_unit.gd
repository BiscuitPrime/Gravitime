extends "res://addons/gut/test.gd"
#Ce script teste les différentes méthodes de la classe Player

var player = preload("res://Source/Actors/Script/Player.gd").new() #On load le script de Player comme nouvelle instance que l'on va tester
var player_scene = preload("res://Source/Actors/Scene/Player.tscn").instance() #On load la scène de Player pour pouvoir considérer ses enfants (comme animation player)
var animation_player = player_scene.get_node("AnimationPlayer") #On charge la node de l'animation du joueur
var sprite = player_scene.get_node("player") #On charge la node du sprite du joueur

#On teste si la méthode save() du joueur fonctionne : (elle doit enregistrer une position)
func test_save():
	player.position=Vector2(3.0,3.0)
	player.save()
	assert_eq(Vector2(3.0,3.0), player.timeposition, "Should succeed : timeposition prends ")

#On teste si la méthode skills() de Player ne modifie pas les états is_attacking ou timeconrol_active sans input de l'utilisateur
func test_skills():
	player.skills()
	assert_eq(player.is_attacking,false,"Should succeed : sans input de l'utilisateur, player n'utilise pas d'attaque : is_attacking = false")
	assert_eq(player.timecontrol_active,false,"Should succeed : sans input de l'utilisateur, player n'utilise pas le rembobinage temporel : timecontrol_active = false")

#On teste la méthode calculate_new_velocity() pour voir si on calcule correctement :
func test_move_velocity():
	var out = player.calculate_move_velocity(Vector2(10,10), Vector2(1,-1), Vector2(800,1600), false)
	assert_eq(out, Vector2(800.0,-1600), "Should succeed : out.x = (800*1) et out.y=-1*1600 car direction.y=-1")

##On teste la méthode movements_animation():
#func test_movements_animation():
#	player._animation_player=animation_player
#	player.sprite=sprite
#	player.movements_animation(Vector2(1,0))
#	assert_eq(player.sprite.flip_h, true, "Should fail : Direction=(1,0) donc sprite.flip_h devrait être égale à false")

#func test_ready():
#	player._animation_player=animation_player
#	player.position=Vector2(5,7)
#	player._ready()
#	assert_eq(player.spawn_position, Vector2(5,7), "Should succeed : spawn_position=player.position=Vector2(5,7)")
#	assert_eq(player.is_in_group("player"), true, "Should succeed : _ready() met Player dans le groupe player")
#	assert_eq(player.is_in_group("timecontrol"), true, "Should succeed : _ready() met Player dans le groupe timecontrol")
