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
	var target_position : Vector2
	if TimeControl.get_clone_exists()==true : #Si un clone temporel existe, le boss va le prioritiser
		for j in get_tree().get_nodes_in_group("timeclone"):
			target_position=j.position
	else : #Si il n'y a
		for i in  get_tree().get_nodes_in_group("player"):
			target_position=i.position
	var direcvector = target_position - position #On oriente le tir du boss
	Projectile.linear_velocity = direcvector.normalized()*2000 #On lui donne une vitesse
	pass # Replace with function body.
