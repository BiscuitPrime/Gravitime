extends Area2D
#Ce script est utilisé par l'attaque du joueur, qui va permettre de tuer un ennemi

#Comme l'attaque doit se conclure rapidement, un timer va se lancer dès que l'attaque est instanciée
#Au bout de celui-ci, l'attaque se détruit
func _ready():
	$DestroyTimer.start()
	pass

#Cette fonction est appellée lorsqu'un corps étranger rentre dans l'attaque
func _on_body_entered(body: Node) -> void:
	if body is Enemy:
		body.hit(1)
	queue_free()
	pass # Replace with function body.

#Fonction qui détruit l'instance de la melee si elle n'a rien touchée
func _on_DestroyTimer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
