class_name Boss
extends Actor
#Ce script est utilisé par le boss

var boss_hp = 3
export (PackedScene) var projectile #On load le projectile du boss

func _ready():
	add_to_group("enemy") #On ajoute le boss au groupe des ennemis

#Cette fonction est appelée lorsque le boss est touché par une attaque critique (i.e. une boîte)
func boss_hit(dmg):
	boss_hp = boss_hp - dmg
	if boss_hp <= 0 :
		queue_free() 
		get_tree().change_scene("res://Source/Levels/Scene/EndScreen.tscn")

func _on_ReloadTimer_timeout() -> void:
	var Projectile = projectile.instance()
	add_child(Projectile)
	var player_position
	for i in get_tree().get_nodes_in_group("player"):
		player_position=i.position
	var direcvector = player_position - position
	Projectile.linear_velocity = direcvector.normalized()*3000
	pass # Replace with function body.
