extends CharacterBody2D

func _on_zone_detection_body_entered(body):
	# On vérifie si l'objet qui entre dans le cône s'appelle bien "Player"
	if body.name == "Player":
		print("Joueur repéré ! Game Over.")
		# On recharge la scène actuelle (ça relance le niveau à zéro)
		get_tree().reload_current_scene()

func disable():
	# 1. On coupe tout (ton code actuel)
	$ZoneDetection.set_deferred("monitoring", false)
	$ZoneDetection.visible = false 
	get_parent().set_process(false) # Arrête le mouvement du PathFollow
	$AnimatedSprite2D.modulate = Color(0.3, 0.3, 0.3)
	
	print("Sentinelle hors-service pour 10 secondes...")
	
	# 2. LE CHRONO : On attend 10 secondes puis on appelle 'reenable'
	# 'create_timer' crée un compte à rebours invisible
	get_tree().create_timer(10.0).timeout.connect(reenable)

func reenable():
	# On remet tout comme avant
	$ZoneDetection.set_deferred("monitoring", true)
	$ZoneDetection.visible = true 
	get_parent().set_process(true) # Relance le mouvement
	$AnimatedSprite2D.modulate = Color.WHITE # Rend sa couleur normale
	print("Sentinelle réactivée ! Attention !")
