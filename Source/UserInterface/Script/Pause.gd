extends Control
#Ce script s'occupe de mettre le jeu en pause et afficher le menu

func _read():
	visible=false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		var new_pause_state=not get_tree().paused
		get_tree().paused=new_pause_state
		visible=new_pause_state
