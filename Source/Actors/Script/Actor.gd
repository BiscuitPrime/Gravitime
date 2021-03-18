extends KinematicBody2D
class_name Actor

#constante indiquant la direction du sol 
const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(800.0, 1600.0)

#ici toutes les varaiables en rapport avec la gravité.
export var gravity: = Vector2(0.0, 3200.0)
export var gravity_factor: = 1.0 #représente le sensibilité à la gravité de l'acteur 
const default_gravity: = Vector2(0.0, 3200.0) #gravité hors des champs 
var is_in_gravity_field:= false #indique si l'acteur est dans un champs
var gravity_area: GravityField #champs dans lequel se tient l'acteur 

var _velocity: = Vector2.ZERO

#Cette fonction commune aux à tous les sert à appliquer la gravité du champs
#dans lequel ils se trouvent.
func apply_gravity(area: GravityField) -> void:
	gravity = area.get_actual_gravity() * gravity_factor
