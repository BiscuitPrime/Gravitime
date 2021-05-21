class_name Enemy
extends "res://Source/Actors/Script/Actor.gd"
#Ce script est utilisé par les ennemis

#On déclare, pour simplifier le code, les variables qui référenceront les Raycast2Ds
onready var DetectorRight = $DetectorRight #Détecte ce qui est en face de lui (entité et mur)
onready var DetectorLeft = $DetectorLeft #Détecte ce qui est en face de lui (entité et mur)
onready var DetectorPlatRight = $DetectorPlatformRight #Détecte ce qui est sous lui (plateformes)
onready var DetectorPlatLeft = $DetectorPlatformLeft #Détecte ce qui est sous lui (plateformes)
onready var _animation_player = $AnimationPlayer
onready var sprite = $enemy
onready var death_sfx = $Death

var timeposition #variable qui va contenir la position de l'ennemi avant la manipulation temporelle

#Cette fonction est appelée lorsque l'instance de l'ennemi est loadée
func _ready():
	add_to_group("timecontrol") #On l'ajoute au groupe timecontrol, ce qui indique que le temps va l'affecter
	add_to_group("enemy")
	_velocity.x = -speed.x #On donne une vitesse initiale à l'ennemi
	_animation_player.play("roule")

#Cette fonction est appelée à chaque frame du jeu 
func _physics_process(delta: float) -> void:
	if is_in_gravity_field:
		apply_gravity(gravity_area)
	_velocity += gravity * delta
	_velocity = move_and_slide(calculate_new_velocity(_velocity), FLOOR_NORMAL)

#This function is used to calculate the new velocity of the enemy
func calculate_new_velocity(_velocity):
	if not DetectorPlatRight.is_colliding() : #Si le détecteur ne détecte pas de plateforme sous l'ennemi, il rebrousse chemin
		_velocity.x=-speed.x
		sprite.flip_h = not sprite.flip_h
	elif not DetectorPlatLeft.is_colliding():
		_velocity.x=speed.x
	elif DetectorLeft.is_colliding() or DetectorRight.is_colliding(): #Si l'ennemi détecte un mur, il rebrousse chemin
		_velocity.x *= -1.0
		sprite.flip_h = not sprite.flip_h
	if _velocity.x==0:
		_velocity.x=-speed.x
	return _velocity

#Cette fonction est appelée lorsque l'ennemi est touché par l'attaque du joueur
func hit(dmg):
	death_sfx.play()
	set_collision_mask_bit(0,false)
	set_collision_layer_bit(1,false)
	hide()
	yield(death_sfx, "finished")
	queue_free() #Pour le moment, l'ennemi sera détruit - plus tard, on mettra un système de vie

#Fonction appelée par TimeControl qui permet de sauvegarder la position du joueur :
func save():
	timeposition=position
	pass

#Fonction appelée par TimeControl qui permet de remettre l'ennemi à sa position d'avant le timeReset
func timeReset():
	position=timeposition
	pass

#Fonction est appelée quand l'ennemi rentre physiquement dans une zone
func _on_PhysicalHitbox_area_entered(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera la gravité de ce champ
		is_in_gravity_field = true
		gravity_area = area

#Fonction est appelée quand l'ennemi sort physiquement dans une zone
func _on_PhysicalHitbox_area_exited(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera plus la gravité de ce champ
		gravity = default_gravity
		is_in_gravity_field = false
