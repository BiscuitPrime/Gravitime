extends Area2D
class_name Laser
#Ce script est utilisé par les lasers qui servent pour les puzzles

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #variable qui va contenir l'animation du laser

#Cette fonction est appelée lorsque le laser est chargé :
func _ready():
	anim_player.play_backwards("shutdown")
	collision_layer=4

func _on_Button_body_entered(body: Node) -> void:
	anim_player.play("shutdown")
	collision_layer=0
	
func _on_Button_body_exited(body: Node) -> void:
	anim_player.play_backwards("shutdown")
	collision_layer=4

#Cette fonction est appelée quand un corps étranger rentre dans le laser
#Si le corps étranger a une méthode hit, on l'appelle
func _on_Laser_body_entered(body: Node) -> void:
	if body.has_method("hit"):
		body.hit(1)
	pass # Replace with function body.
