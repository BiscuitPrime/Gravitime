class_name Level_End
extends Area2D
#Ce script est utilisé par le portail qui permet le changement de niveau

onready var animation = $AnimationPlayer

export var next_level : PackedScene

#This function is called when the player changes level
func change_level():
	animation.play("changing_level")
	yield(animation,"animation_finished")
	get_tree().change_scene_to(next_level)
	pass

func _on_Level_End_body_entered(body):
	if body.is_in_group("player"):
		change_level()
		body.changing_level()
	pass # Replace with function body.
