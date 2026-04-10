extends StaticBody2D

func interact(_player):
	$AnimatedSprite2D.play("talk")
	get_tree().call_group("hud", "show_hud_directive", [
		"Le code secret du terminal de sortie est : 0 4 2 6",
		"Fais vite !"
	], "ALLIÉ :")
	get_tree().create_timer(4.0).timeout.connect(func(): $AnimatedSprite2D.play("idle"))
