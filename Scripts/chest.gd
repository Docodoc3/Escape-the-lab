extends StaticBody2D

var is_open: bool = false # C'est cette ligne qui manquait !

func interact(player):
	if is_open: return
	is_open = true
	$AnimatedSprite2D.play("open")
	player.has_key = true
	get_tree().call_group("hud", "show_key")
	get_tree().call_group("hud", "show_hud_directive", ["Puce RFID récupérée !"], "INVENTAIRE :")
