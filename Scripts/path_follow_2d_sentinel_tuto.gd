extends PathFollow2D

const SPEED = 100.0

# On mémorise la position complète (X et Y)
var last_position = Vector2.ZERO

func _process(delta):
	# 1. On enregistre la position avant de bouger
	last_position = global_position
	
	# 2. On fait avancer la sentinelle
	progress += SPEED * delta
	
	# 3. On calcule la direction exacte en comparant l'ancienne et la nouvelle position
	var direction = global_position - last_position
	
	var anim = $Sentinel/AnimatedSprite2D
	var zone = $Sentinel/ZoneDetection
	
	# On s'assure qu'elle bouge vraiment avant de la faire tourner (évite les tremblements)
	if direction.length() > 0.1:
		
		# On vérifie quel mouvement est le plus fort : Horizontal (X) ou Vertical (Y) ?
		if abs(direction.x) > abs(direction.y):
			# === MOUVEMENT HORIZONTAL ===
			if direction.x > 0:
				# Va vers la droite
				anim.flip_h = false
				zone.rotation_degrees = 0 # Le cône pointe à droite
			else:
				# Va vers la gauche
				anim.flip_h = true
				zone.rotation_degrees = 180 # Le cône pointe à gauche
		else:
			# === MOUVEMENT VERTICAL ===
			if direction.y > 0:
				# Va vers le bas
				zone.rotation_degrees = 90 # Le cône pointe en bas
			else:
				# Va vers le haut
				zone.rotation_degrees = -90 # Le cône pointe en haut
