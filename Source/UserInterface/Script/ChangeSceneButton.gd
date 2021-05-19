tool
extends Button
#Un bouton pour charger une scène

#Chemin vers la prochaine scène. Le "FILE" indique qu'il pourra parcourir un fichier pour trouver le chemin vers le prochain niveau
export(String, FILE) var next_scene_path := ""

#Quand on relâche le bouton, la scène suivante est chargée
func _on_ChangeSceneButton_button_up() -> void:
	GeneralData.reset()
	get_tree().change_scene(next_scene_path)

#Simple avertissement au cas où le chemin est vide
func _get_configuration_warning() -> String:
	return "next_scene_path must be set for the button to work" if next_scene_path == "" else ""
