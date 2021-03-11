extends Area2D
class_name Laser

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

func _ready():
	anim_player.play_backwards("shutdown")
	get_node("CollisionShape2D").set_disabled(false)

func _on_DoorButton_body_entered(body: Node) -> void:
	anim_player.play("shutdown")
	get_node("CollisionShape2D").set_disabled(true)
	
func _on_DoorButton_body_exited(body: Node) -> void:
	anim_player.play_backwards("shutdown")
	get_node("CollisionShape2D").set_disabled(false)
