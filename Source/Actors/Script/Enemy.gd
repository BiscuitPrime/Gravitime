class_name Enemy
extends "res://Source/Actors/Script/Actor.gd"
#Ce script est utilisé par les ennemis

func _ready():
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if is_on_wall():
		_velocity.x *= -1.0 

#Cette fonction est appelée lorsque l'ennemi est touché par l'attaque du joueur
func hit():
	queue_free() #Pour le moment, l'ennemi sera détruit
