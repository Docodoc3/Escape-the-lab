extends CharacterBody2D

func _on_zone_detection_body_entered(body):
	if body.name == "Player":
		body.take_damage()
		# On déplace le joueur sur le sol pour éviter d'être coincé dans un mur
		body.global_position = Vector2(150, 720) 

func disable(): # Appelé par le hacking
	$ZoneDetection.set_deferred("monitoring", false)
	$ZoneDetection.visible = false 
	get_parent().set_process(false) 
	$AnimatedSprite2D.modulate = Color(0.3, 0.3, 0.3)
	get_tree().create_timer(10.0).timeout.connect(reenable) #

func reenable():
	$ZoneDetection.set_deferred("monitoring", true)
	$ZoneDetection.visible = true 
	get_parent().set_process(true) 
	$AnimatedSprite2D.modulate = Color.WHITE #
