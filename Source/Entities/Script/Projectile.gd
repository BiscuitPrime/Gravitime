extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("projectile")
	$LifeTimer.start() #On commence le timer de vie du projectile
	pass # Replace with function body.

#Fonction appelée lorsque le projectile "meurt"
func _on_LifeTimer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
