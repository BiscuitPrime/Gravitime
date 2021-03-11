class_name Player
extends Actor
#Ce script est utilisé par le joueur

export (PackedScene) var Melee #Contient la scène de l'attaque qui sera utilisée

export (int, 0, 200) var push = 100 #Impulsion qui permet de déplacer les RigidBody2D

#On déclare les variables :
var spawn_position : Vector2 #Cette variable va stocker la position du spawn du joueur 
var is_attacking=false #Indique si le joueur attaque ou non
var facing = true #cette variable va indiquer dans quel sens le joueur se tient : true si x>0, false sinon

#Cette fonction est appelée lors de l'instanciation du joueur
func _ready():
	#On initialise la var spawn_position du joueur sur sa position une fois initialisé 
	#position donnée lors du placement de l'instance joueur lors de la création du niveau
	spawn_position=position 
	pass

#Cette fonction est appelée à chaque frame du jeu
func _physics_process(delta: float) -> void:
	skills() #Cette fonction va tester si le joueur fait une action ou non
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	facing=_velocity.x<0
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, false,
					4, PI/4, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Pushables"):
				collision.collider.apply_central_impulse(-collision.normal * push)

#Fonction qui traduit les inputs du joueur en direction
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)

#Fonction qui calcule la vitesse du joueur
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
		hit(1)
	if body is Laser: #FIXME: supposé appeler la fonction "hit" du joueur
		hit(1)
	pass 

#Fonction appelée lorsque le joueur prends un dégât
func hit(dmg):
	var life = GeneralData.player_hp #On créer une variable locale pour simplifier code
	if (life-dmg) > 0 :
		GeneralData.player_hp=life-dmg
	else :
		die()
	position=spawn_position
	pass

#Fonction appelée lorsque le joueur meurt
#Pour le moment, elle se contente de détruire l'instance du joueur
func die():
	queue_free()

#Fonction appelée à chaque frame et indiquant si le joueur utilise un skill ou non
func skills():
	if Input.is_action_just_pressed("attack") and is_attacking==false:
		attack() #Un des skills est d'attaquer
		is_attacking=true
	pass

#Fonction appelée lorsque le joueur attaque
func attack():
	var melee = Melee.instance()
	get_parent().add_child(melee)
	if facing == false:
		melee.position=get_global_position()+Vector2(100,-50)
	else:
		melee.position=get_global_position()+Vector2(-100,-50)
	$ReloadTimer.start()
	yield($ReloadTimer, "timeout")
	is_attacking=false
	pass
