extends Button
#Un bouton pour recharger un niveau depuis le menu pause

func _on_RetryButton_button_up() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
