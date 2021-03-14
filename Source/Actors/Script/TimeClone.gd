class_name TimeClone
extends KinematicBody2D
#Ce script est utilisé par le clone temporel du joueur

#Cette fonction est appelée lorsque le clone rentre en contact avec un corps étranger :
func _on_PhysicalHitbox_body_entered(body: Node) -> void:
	if body is Enemy: #Si le corps étranger est un enemy, on appelle la fonction "hit" du clone
		hit(1)
	pass 

#Fonction appelée lorsque le clone prends un dégât
func hit(dmg):
	die() #Pour le moment, le clone meurt immédiatement au premier dégât reçu
	pass

#Fonction appelée lorsque le clone meurt
#Pour le moment, elle se contente de détruire l'instance du clone
func die():
	queue_free()

#Fonction appelée lorsque le clone attaque
func attack():
	pass
