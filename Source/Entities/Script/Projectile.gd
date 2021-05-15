extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("projectile")
	pass # Replace with function body.

#Fonction appelée lorsque le projectile "meurt"
func _on_LifeTimer_timeout() -> void:
	queue_free()
	pass # Replace with function body.

#Fonction appelée lorsque le projectile touche la tilemap
func _on_Projectile_body_entered(body: Node) -> void:
	if body.has_method("hit"):
		body.hit(1)
	queue_free()
	pass # Replace with function body.
