extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _on_body_entered(body: KinematicBody2D) -> void: #
	anim_player.play("pushed")

func _on_body_exited(body: KinematicBody2D) -> void:
	anim_player.play_backwards("pushed")

