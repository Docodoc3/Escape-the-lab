extends CharacterBody2D

func _on_zone_detection_body_entered(body):
	if body.name == "Player":
		print("Joueur détecté !")
		body.take_damage()
		
		# On téléporte le joueur à un endroit sûr (coordonnées sol bleu)
		# Ajuste ces valeurs si tu veux un point précis
		body.global_position = Vector2(150, 720) 

func disable():
	$ZoneDetection.set_deferred("monitoring", false)
	$ZoneDetection.visible = false 
	get_parent().set_process(false) 
	$AnimatedSprite2D.modulate = Color(0.3, 0.3, 0.3)
	get_tree().create_timer(10.0).timeout.connect(reenable)

func reenable():
	$ZoneDetection.set_deferred("monitoring", true)
	$ZoneDetection.visible = true 
	get_parent().set_process(true) 
	$AnimatedSprite2D.modulate = Color.WHITE
