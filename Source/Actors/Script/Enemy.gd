class_name Enemy
extends "res://Source/Actors/Script/Actor.gd"
#Ce script est utilisé par les ennemis

func _ready():
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	if is_in_gravity_field:
		apply_gravity(gravity_area)
	_velocity += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if is_on_wall():
		_velocity.x *= -1.0 

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
