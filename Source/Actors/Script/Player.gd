class_name Player
extends Actor
#Ce script est utilisé par le joueur

#On déclare les variables :
var spawn_position : Vector2 #Cette variable va stocker la position du spawn du joueur 

#Cette fonction est appelée lors de l'instanciation du joueur
func _ready():
	#On initialise la var spawn_position du joueur sur sa position une fois initialisé 
	#position donnée lors du placement de l'instance joueur lors de la création du niveau
	spawn_position=position 
	pass

#Cette fonction est appelée à chaque frame du jeu
func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

#Cette fonction est appelée lorsque le joueur rentre en contact avec un corps étranger :
func _on_PhysicalHitbox_body_entered(body: Node) -> void:
	if body is Enemy: #Si le corps étranger est un enemy, on appelle la fonction "hit" du joueur
		hit()
	pass 

#Fonction appelée lorsque le joueur prends un dégât
func hit():
	GeneralData.player_hp=GeneralData.player_hp-1
	position=spawn_position
	pass
