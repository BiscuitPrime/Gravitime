class_name Boss
extends Actor
#Ce script est utilisé par le boss

var boss_hp = 3
export(PackedScene) var box_scene
export (PackedScene) var projectile #On load le projectile du boss

func _ready():
	add_to_group("enemy") #On ajoute le boss au groupe des ennemis

#Cette fonction est appelée lorsque le boss est touché par une attaque critique (i.e. une boîte)
func boss_hit(dmg):
	boss_hp = boss_hp - dmg
	if boss_hp <= 0 :
		queue_free() 
		get_tree().change_scene("res://Source/Levels/Scene/EndScreen.tscn")

func _on_BoxSpawnTimer_timeout() -> void:
	var box_spawn_location = get_node("BoxPath/BoxSpawnLocation")
	var box = box_scene.instance()
	add_child(box)
	box.position = box_spawn_location.position
	

func _on_ReloadTimer_timeout() -> void:
	var Projectile = projectile.instance()
	add_child(Projectile)
	var direction
	for i in get_tree().get_nodes_in_group("player"):
		direction=i.position
	Projectile.linear_velocity = direction
	pass # Replace with function body.
