class_name Enemy
extends "res://Source/Actors/Script/Actor.gd"
#Ce script est utilisé par les ennemis

#On déclare, pour simplifier le code, les variables qui référenceront les Raycast2Ds
onready var DetectorRight = $DetectorRight #Détecte ce qui est en face de lui (entité et mur)
onready var DetectorLeft = $DetectorLeft #Détecte ce qui est en face de lui (entité et mur)
onready var DetectorPlatRight = $DetectorPlatformRight #Détecte ce qui est sous lui (plateformes)
onready var DetectorPlatLeft = $DetectorPlatformLeft #Détecte ce qui est sous lui (plateformes)

#Cette fonction est appelée lorsque l'instance de l'ennemi est loadée
func _ready():
	_velocity.x = -speed.x #On donne une vitesse initiale à l'ennemi

#Cette fonction est appelée à chaque frame du jeu 
func _physics_process(delta: float) -> void:
	if is_in_gravity_field:
		apply_gravity(gravity_area)
	_velocity += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if is_on_wall():
		_velocity.x *= -1.0 
	_velocity.y += gravity * delta
	_velocity = move_and_slide(calculate_new_velocity(_velocity), FLOOR_NORMAL)

#This function is used to calculate the new velocity of the enemy
func calculate_new_velocity(_velocity):
	if not DetectorPlatRight.is_colliding() : #Si le détecteur ne détecte pas de plateforme sous l'ennemi, il rebrousse chemin
		_velocity.x=-speed.x
	elif not DetectorPlatLeft.is_colliding():
		_velocity.x=speed.x
	elif DetectorLeft.is_colliding() or DetectorRight.is_colliding():
		_velocity.x *= -1.0
	return _velocity

#Cette fonction est appelée lorsque l'ennemi est touché par l'attaque du joueur
func hit(dmg):
	queue_free() #Pour le moment, l'ennemi sera détruit - plus tard, on mettra un système de vie


func _on_PhysicalHitbox_area_entered(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera la gravité de ce champ
		is_in_gravity_field = true
		gravity_area = area

func _on_PhysicalHitbox_area_exited(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera plus la gravité de ce champ
		gravity = default_gravity
		is_in_gravity_field = false
