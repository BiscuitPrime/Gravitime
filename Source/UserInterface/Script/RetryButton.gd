extends Button
#Un bouton pour continuer le niveau depuis le menu pause

func _on_RetryButton_button_up() -> void:
	get_tree().paused = false
	get_parent().visible=false
