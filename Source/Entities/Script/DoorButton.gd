extends Area2D
var nb_corps = 0 #Variable qui compte le nombre de corps occupant le bouton
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	anim_player.play_backwards("pushed")

func _on_body_entered(body: KinematicBody2D) -> void:
	nb_corps += 1
	if nb_corps == 1: #Ne rejoue pas l'animation si le bouton était déjà enfoncé
		anim_player.play("pushed")

func _on_body_exited(body: KinematicBody2D) -> void:
	nb_corps -= 1
	if nb_corps == 0: #Ne joue pas l'animation tant que le bouton n'est pas entièrement relâché
		anim_player.play_backwards("pushed")
