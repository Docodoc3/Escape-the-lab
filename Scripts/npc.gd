extends StaticBody2D

func interact(_player):
	$AnimatedSprite2D.play("talk") #
	get_tree().call_group("hud", "show_hud_directive", ["Le code secret est : 0 4 2 6"], "ALLIÉ :") #
