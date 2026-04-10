extends StaticBody2D

var is_open: bool = false

func interact(player):
	if is_open:
		return 
	
	# 1. Changer l'apparence
	$AnimatedSprite2D.play("open")
	is_open = true
	
	# 2. Donner la clé au joueur
	player.has_key = true
	print("Clé récupérée !")
	
	# 3. NOUVEAU : On envoie un signal radio au HUD pour allumer l'icône !
	get_tree().call_group("hud", "show_key")
