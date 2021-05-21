extends Button
#Un bouton pour quitter le jeu

func _on_QuitButton_button_up() -> void:
	get_tree().quit()
