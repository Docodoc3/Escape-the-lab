extends StaticBody2D

var is_locked: bool = true

func interact(player):
	if not is_locked:
		return
		
	if player.has_key:
		player.has_key = false
		get_tree().call_group("hud", "hide_key")
		open_door()
	else:
		# Le joueur n'a pas la clé ! On lance une alerte sur le HUD.
		get_tree().call_group("hud", "show_hud_directive", [
			"Accès refusé. Serrure électronique verrouillée.",
			"Veuillez trouver la carte d'accès pour continuer."
		], "AVERTISSEMENT :", 3.0)

func open_door():
	is_locked = false
	$AnimatedSprite2D.play("open")
	$CollisionShape2D.set_deferred("disabled", true)
