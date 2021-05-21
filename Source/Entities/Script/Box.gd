extends RigidBody2D
#Ce script est utilisé par la caisse

var nb_champs = 0 #Variable qui compte le nombre de champs dans lesquels la boîte se trouve
var timeposition #variable qui contiendra la position de la caisse lorsqu'elle remontera le temps

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_sleep = false
	set_friction(0.7)
	add_to_group("timecontrol") #On l'ajoute au groupe timecontrol, ce qui indique que le temps va l'affecter
	pass # Replace with function body.

#fonction qui enregistre la position de la caisse afin de produire le rembobinage temporel
func save():
	timeposition=position

#fonction qui est appelée par TimeControl et permet le "rembobinage temporel" de la caisse :
func timeReset():
	position=timeposition

#fonction appelée dès que la caisse entre dans une zone. Teste notamment si la caisse  est rentrée dans un champ de gravité pour activer les effets de ce dernier.
func _on_PhysicalHitbox_area_entered(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera constamment la gravité
		nb_champs += 1
		if nb_champs == 1:
			can_sleep = false

#fonction appelée dès que la caisse sort d’une zone. Teste notamment si la caisse  est sortie d’un champ de gravité pour désactiver les effets de ce dernier.
func _on_PhysicalHitbox_area_exited(area: Area2D) -> void:
	#Si le corps est un champ de gravité, on appliquera la gravité normale 
	#uniquement lorsque la caisse est bousculée/en mouvement.
	if area is GravityField: 
		nb_champs -= 1
		if nb_champs == 0:
			can_sleep = true