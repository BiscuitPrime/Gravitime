class_name TimeClone
extends Actor
#Ce script est utilisé par le clone temporel du joueur

export (PackedScene) var Melee #Contient la scène de l'attaque qui sera utilisée

var inputs #cette variable va contenir les inputs stockés du joueur, que le clone va devoir reproduire
var i=0 #Utilisé pour parcourir l'array d'inputs
var input #contiendra l'input à une frame précise
var n #contient la taille de inputs
var facing = true #cette variable va indiquer dans quel sens le clone du joueur se tient : true si x>0, false sinon
onready var _animation_player = $AnimationPlayer #pour l'animation du clone 
onready var sprite = $TimeClone #pour changer rapidement le sens du sprite

#Cette fonction est appelée lors de l'initialisation du clone
func _ready():
	add_to_group("timeclone")
	TimeControl.set_clone_exists(true) #On indique au jeu qu'un clone temporel existe
	inputs=TimeControl.get_player_inputs() #Lors de l'initialisation du clone temporel, on lui donne un array contenant les inputs du joueur lors de la sélection temporel
	n=inputs.size()
	$TimeResetTimer.start()#on lance le timer de "vie" du clone
	$CollisionTimer.start()#Lance le timer de collision du clone (collision avec joueur)
	pass

#Cette fonction est appelée à chaque frame du jeu:
func _physics_process(delta: float) -> void:
	input = inputs[i] #nous lisons un à un les éléments de la liste inputs (une lectudqre par frame)
	clone_action(input) #on appelle la fonction qui va diriger toutes les actions du clone
	print(input)
	var is_jump_interrupted:bool = input=="jump" and _velocity.y < 0.0 #On détermine si le clone voit son saut s'interrompre ou non
	var direction :Vector2 = get_direction() #On détermine la direction du clone
	movements_animation(direction)
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted) #On calcule la nouvelle vélocité du clone
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, false, 4, PI/4, false) #On applique la vélocité au clone
	if i<n-1: #On parcourt la liste des inputs du joueur
		i=i+1
	else :
		die() #lorsque toute la liste est lue, le clone meurt (pour le moment, cette ligne est redondante avec le Timer TimeResetTimer)
	pass

#Cette fonction calcule la vitesse du clone - elle fonctionne de la même manière que pour Player
func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out

#Cette fonction va déterminer la direction du clone, utilisée pour les sauts et les mouvements généraux
func get_direction():
	var h_direction=0 #Sans informations externes, le clone n'a pas de direction
	if input=="move_right":
		h_direction=1.0
	elif input=="move_left":
		h_direction=-1.0
	return Vector2(
		h_direction,
		-1.0 if input=="jump" and is_on_floor() else 1.0
	)

#fonction qui détermine quelle animation correspond au mouvement actuel pour le clone
func movements_animation(direction: Vector2) -> void:
	var anim_actuelle = _animation_player.get_current_animation() 
	#on oriente le sprite dans le bon sens en fonction de la direction
	if direction.x > 0 :
			sprite.flip_h = false 
	elif direction.x < 0 :
			sprite.flip_h = true
	if is_on_floor() and anim_actuelle != "hit" and anim_actuelle!= "attaque" :
		if direction.y < 0 :
			_animation_player.play("saut")
		elif direction.x != 0 :
			_animation_player.play("marche")
		else : 
			_animation_player.play("stand by")

#Cette fonction est appelée à chaque frame et détermine comment le clone du joueur agit :
func clone_action(input):
	if input=="attack":
		attack()
		_animation_player.play("attaque")
	elif input=="jump":
		jump()
	pass

#Cette fonction est appelée lorsque le clone saute :
func jump():
	_velocity.y=-speed.y
	_velocity=move_and_slide(_velocity)
	pass

#Cette fonction est appelée lorsque le clone rentre en contact avec un corps étranger :
func _on_PhysicalHitbox_body_entered(body: Node) -> void:
	if body is Enemy: #Si le corps étranger est un enemy, on appelle la fonction "hit" du clone
		hit(1)
	pass 

#Fonction appelée lorsque le clone prends un dégât
func hit(dmg):
	_animation_player.play("hit")
	die() #Pour le moment, le clone meurt immédiatement au premier dégât reçu
	pass

#Fonction appelée lorsque le clone meurt
#Pour le moment, elle se contente de détruire l'instance du clone
func die():
	TimeControl.set_clone_exists(false) #On indique au jeu que le clone n'existe plus
	queue_free()

#Fonction appelée lorsque le clone attaque
func attack():
	var melee = Melee.instance()
	get_parent().add_child(melee)
	if facing == false:
		melee.position=get_global_position()+Vector2(100,-50)
	else:
		melee.position=get_global_position()+Vector2(-100,-50)
	$ReloadTimer.start()
	yield($ReloadTimer, "timeout")
	pass

#Fonction appelée lorsque le clone atteint le bout de sa "vie"
func _on_TimeResetTimer_timeout() -> void:
	die()
	pass # Replace with function body.

#Fonction appelée lorsque le clone s'écarte suffisament du joueur
func _on_CollisionTimer_timeout() -> void:
	set_collision_mask_bit(0,true)
	pass # Replace with function body.

#Cette fonction est appelée quand le joueur rentre dans une zone
func _on_PhysicalHitbox_area_entered(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera la gravité de ce champ
		is_in_gravity_field = true
		gravity_area = area

#Cette fonction est appelé quand le joueur quitte une zone 
func _on_PhysicalHitbox_area_exited(area: Area2D) -> void:
	if area is GravityField: #Si le corps est un champ de gravité, on appliquera plus la gravité de ce champ
		gravity = default_gravity
		is_in_gravity_field = false
