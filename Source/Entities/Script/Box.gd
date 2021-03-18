extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_sleep = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_PhysicalHitbox_area_entered(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera constamment la gravité
		can_sleep = false



func _on_PhysicalHitbox_area_exited(area: Area2D) -> void:
	#Si le corps est un champ de gravité, on appliquera la gravité normale 
	#uniquement lorsque la caisse est bousculée/en mouvement.
	if area is GravityField: 
		can_sleep = true
