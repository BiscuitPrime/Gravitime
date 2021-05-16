class_name Player
extends Actor
#Ce script est utilisé par le joueur

export (PackedScene) var Melee #Contient la scène de l'attaque qui sera utilisée
export (PackedScene) var Clone #Contient le clone temporel qui sera utilisé
export (PackedScene) var DeathScreen #Contient le screen de mort
export (PackedScene) var TimeHUD #Contient l'HUD du rembobinage temporel

export (int, 0, 200) var push = 75 #Impulsion qui permet de déplacer les RigidBody2D

#On déclare les variables :
var spawn_position : Vector2 #Cette variable va stocker la position du spawn du joueur 
var is_attacking=false #Indique si le joueur attaque ou non
var facing = true #cette variable va indiquer dans quel sens le joueur se tient : true si x>0, false sinon
var timecontrol_active = false #cette variable indique si le joueur est e train de manipuler le temps ou non
var timeposition #variable qui contiendra la position du joueur lorsqu'il remontera le temps
onready var _animation_player = $AnimationPlayer #pour l'animation du joueur 
onready var sprite = $player #pour changer rapidement le sens du sprite


#Cette fonction est appelée lors de l'instanciation du joueur
func _ready():
	#On initialise la var spawn_position du joueur sur sa position une fois initialisé 
	#position donnée lors du placement de l'instance joueur lors de la création du niveau
	spawn_position=position 
	_animation_player.play("stand by")
	add_to_group("timecontrol") #On l'ajoute au groupe timecontrol, ce qui indique que le temps va l'affecter
	add_to_group("player")
	pass

#Cette fonction est appelée à chaque frame du jeu
func _physics_process(delta: float) -> void:
	skills() #Cette fonction va tester si le joueur fait une action ou non
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	movements_animation(direction)
	if is_in_gravity_field:
		apply_gravity(gravity_area)
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)

	_velocity = move_and_slide(_velocity, FLOOR_NORMAL, false, 4, PI/4, false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Pushables"):
				collision.collider.apply_central_impulse(-collision.normal * push)
	if timecontrol_active==true:
		timeInputs()
	pass

#Fonction qui traduit les inputs du joueur en direction
func get_direction() -> Vector2:
	var test_facing = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") #On détermine dans quel sens le joueur "regarde"
	if test_facing <0: #Si la direction générale est la droite, on oriente le joueur vers la droite (true pour la variable facing)
		facing=true
	elif test_facing>0:
		facing=false
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") and is_on_floor() else 1.0
	)

#Fonction qui permet de lancer au bon moment les animations de déplacements
func movements_animation(direction: Vector2) -> void:
	var anim_actuelle = _animation_player.get_current_animation() 
	if direction.x > 0 :
			sprite.flip_h = false 
	elif direction.x < 0 :
			sprite.flip_h = true
	if is_on_floor() and anim_actuelle != "hit" and anim_actuelle != "mort" and anim_actuelle!= "attaque" :
		if direction.y < 0 :
			_animation_player.play("saut")
		elif direction.x != 0 :
			_animation_player.play("marche")
		else : 
			_animation_player.play("stand by")

#Fonction qui calcule la vitesse du joueur
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

#Cette fonction est appelée lorsque le joueur rentre en contact avec un corps étranger :
func _on_PhysicalHitbox_body_entered(body: Node) -> void:
	if body.is_in_group("enemy"):
		hit(1)
	pass

#Fonction appelée lorsque le joueur prends un dégât
func hit(dmg):
	var life = GeneralData.player_hp #On créer une variable locale pour simplifier code
	if (life-dmg) > 0 :
		_animation_player.stop(true)
		_animation_player.play("hit")
		GeneralData.player_hp=life-dmg
	else :
		die()
	position=spawn_position
	pass

#Fonction appelée lorsque le joueur meurt
#Pour le moment, elle se contente de détruire l'instance du joueur
func die():
	_animation_player.stop()
	_animation_player.play("mort")
	yield(_animation_player, "animation_finished")
	queue_free()
	get_tree().change_scene_to(DeathScreen) #On charge le DeathScreen
	GeneralData.player_hp=10 #On réinitialise la vie du joueur pour les parties suivantes

#Fonction appelée à chaque frame et indiquant si le joueur utilise un skill ou non
func skills():
	if Input.is_action_just_pressed("attack") and is_attacking==false: #Si le joueur appuie sur attaque (et il n'est pas déjà en train d'attaquer)
		attack() #Un des skills est d'attaquer, on appelle 
		is_attacking=true
		_animation_player.play("attaque")
	if Input.is_action_just_pressed("time") and timecontrol_active==false:
		TimeControl.timereset() #On demande à TimeControl de lancer la fonction de reset temporel
		timecontrol_active=true #On indique que l'on remonte le temps
		var timeHUD = TimeHUD.instance() #On affiche l'HUD du timer temporel
		add_child(timeHUD)
	pass

#Fonction appelée lorsque le joueur attaque
func attack():
	var melee = Melee.instance()
	get_parent().add_child(melee)
	if facing == false:
		melee.position=get_global_position()+Vector2(100,-30)
	else:
		melee.position=get_global_position()+Vector2(-100,-30)
	$ReloadTimer.start()
	yield($ReloadTimer, "timeout")
	is_attacking=false
	pass

#Fonction appelée par TimeControl qui permet de sauvegarder la position du joueur :
func save():
	timeposition=position
	pass

#Fonction appelée par TimeControl qui permet de remettre le joueur à sa position d'avant le timeReset
func timeReset():
	position=timeposition
	timecontrol_active=false #On indique que on ne controle plus le temps (on peut recommencer à le modifier)
	print(TimeControl.get_player_inputs())
	var clone = Clone.instance()
	get_parent().add_child(clone)
	clone.position=get_global_position()
	pass

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

#Cette fonction est appelée à chaque frame lorsque le joueur lance le rembobinage temporel
#Elle va enregistrer les actions du joueur afin que le clone temporel puisse les refaire
func timeInputs():
	if Input.is_action_just_pressed("attack"):
		TimeControl.set_player_inputs("attack")
	elif Input.is_action_pressed("jump"):
		TimeControl.set_player_inputs("jump")
	elif Input.is_action_pressed("move_left"):
		TimeControl.set_player_inputs("move_left")
	elif Input.is_action_pressed("move_right"):
		TimeControl.set_player_inputs("move_right")
	else:
		TimeControl.set_player_inputs(null)
	pass
