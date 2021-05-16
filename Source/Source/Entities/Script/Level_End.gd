class_name Level_End
extends Area2D
#Ce script est utilisé par le portail qui permet le changement de niveau

onready var animation = $AnimationPlayer

export var next_level : PackedScene

func _ready() -> void:
	animation.play("portail_mouvement")
#Cette fonction est appelée lorsque le joueur change de niveau
#Elle permet de changer de niveau
func change_level():
	animation.play("changing_level")
	yield(animation,"animation_finished")
	get_tree().change_scene_to(next_level)
	pass

#Cette fonction est lancée lorsque le joueur rentre en contact avec le portail
func _on_Level_End_body_entered(body):
	if body.is_in_group("player"):
		change_level() #On appelle la fonction changement de niveau
	pass # Replace with function body.
