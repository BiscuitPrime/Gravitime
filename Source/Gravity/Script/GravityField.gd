class_name GravityField
extends Area2D

#déclaration des champs de la zone.
var gravity_field: = Vector2(0, 3200) # Vecteur champ de gravité utilisé par les actors
export var norm_max: = 6400
export var norm_min: = 300
var norm_default: = norm_max/2 #norme par défault à l'instanciation du champ
export var sensibility: = 15 #facteur de sensibilité de changement de la gravité pour la souris
# coordoonées du dernier clic (utile pour calculer nouveau vecteur champ):
var origin: = position
#booléen pour indiquer si le jouer est en train de modifier le champ
var is_dragging: = false 
var is_in_zone: = false #indique si la souris est dans la zone


# fonction appelé à la création du champs
func _ready() -> void:
	gravity_field = Vector2(0,1)*norm_default
	gravity_vec = (gravity_field/norm_default)*98
	pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
#Pour le moment, elle ne sert que pour des tests (d'où le fait qu'elle soit en commentaire)
#func _process(delta: float) -> void:
	#print("gravity: ", gravity_field)

#Appelée dès qu'un événement se produit 
#Cette fonction est chargée de détecter les modifications
#de la gravité dans la zone et de les appliquer. 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT :
		if is_in_zone:
			#si le clic est dans la zone, on définit l'origin, et 
			#on active le changement de gravité
			if not is_dragging and event.pressed:
				origin = event.position
				is_dragging = true
				
		#si on relâche le bouton, on arrête de modifier le champ
		if is_dragging and not event.pressed:
			is_dragging = false
			
	#si le bouton est maintenu, on utilise la position de la souris pour
	#calculer le nouveau vecteur.
	if event is InputEventMouseMotion and is_dragging:
		gravity_field = calculate_gravity(origin, event.position)
		indique_sens_intensite((gravity_field.angle() - PI/2), gravity_field.length()/norm_max)
				

func indique_sens_intensite(angle: float, intensite: float) -> void:
	var enfants = get_node("Sprite").get_children()
	for enfant in enfants :
		enfant.rotation = angle
		enfant.scale = Vector2(0.4 - 0.2*intensite,0.3*intensite)
		

#Cette fonction permet de récupérer le vecteur champ de gravité depuis les 
#autres scripts (utile pour les actors et entities)
func get_actual_gravity() -> Vector2:
	return gravity_field


#Cette fonction calcule le nouveau vecteur gravité à partir
#du point d'origine (clic de la souris) à la position finale
#(coordonées de la souris).  
func calculate_gravity(origin: Vector2, end: Vector2) -> Vector2:
	var grav : = sensibility * (end - origin)
	grav = grav.clamped(norm_max) #on limite la norme max de la gravité.
	grav = max(grav.length(), norm_min) * grav.normalized() #on limite la norme min également
	gravity_vec = (grav/norm_default)*98 #cette ligne sert pour les rigid body 2D qui font appel au moteur physique de godot
	return grav

#quand la souris rentre dans la zone
func _on_GravityField_mouse_entered() -> void:
	is_in_zone = true

#quand la souris sort de la zone
func _on_GravityField_mouse_exited() -> void:
	is_in_zone = false
