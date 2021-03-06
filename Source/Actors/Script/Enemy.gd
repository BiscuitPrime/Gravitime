extends "res://Source/Actors/Script/Actor.gd"

func _ready():
	_velocity.x = -speed.x

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	if is_on_wall():
		_velocity.x *= -1.0 
	
	
