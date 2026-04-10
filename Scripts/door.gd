extends StaticBody2D

func interact(player):
	if player.has_key:
		$AnimatedSprite2D.play("open")
		$CollisionShape2D.set_deferred("disabled", true)
		get_tree().call_group("hud", "show_hud_directive", ["Accès autorisé : porte ouverte."], "SYSTÈME :")
	else:
		get_tree().call_group("hud", "show_hud_directive", ["Accès refusé : puce RFID requise."], "ERREUR :")
