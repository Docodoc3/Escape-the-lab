extends CharacterBody2D

# Vitesse de déplacement du joueur
const SPEED = 150.0

var has_key: bool = false

# On récupère le noeud d'animation pour pouvoir le contrôler
@onready var anim = $AnimatedSprite2D

func _ready():
	add_to_group("player")

func _physics_process(delta):
	# 1. Obtenir la direction voulue par le joueur (flèches ou joystick)
	# On utilise maintenant nos propres actions ZQSD !
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# 2. Calculer la vélocité
	velocity = direction * SPEED

	# 3. Gérer les animations et l'orientation du sprite
	if direction != Vector2.ZERO:
		anim.play("run")
		# Si on se déplace sur l'axe X, on retourne le sprite selon la direction
		if direction.x != 0:
			anim.flip_h = direction.x < 0
	else:
		anim.play("idle")

	# 4. Appliquer le mouvement et gérer les collisions avec les murs
	move_and_slide()

func _input(event):
	if event.is_action_pressed("interact"): # La touche E
		print("J'ai appuyé sur E !")
		# On regarde toutes les zones qui touchent le joueur
		var targets = $InteractionArea.get_overlapping_areas()
		
		for target in targets:
			# Si l'objet a une fonction interact, on l'appelle
			if target.has_method("interact"):
				target.interact(self)
				break # On n'interagit qu'avec un objet à la fois
			
			# Cas spécial pour la porte (on cherche l'interaction sur le parent StaticBody)
			elif target.get_parent().has_method("interact"):
				target.get_parent().interact(self)
				break
