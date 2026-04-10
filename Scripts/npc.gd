extends StaticBody2D

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("idle")

func interact(player):
	# On joue l'animation
	anim.play("talk")
	
	# On affiche la bulle (le HUD va fermer l'ancienne si on spamme le bouton E)
	get_tree().call_group("hud", "show_dialogue", [
		"Psst ! Je connais le secret du terminal...",
		"Il faut cliquer sur les chiffres dans cet ordre :",
		"0... puis 4... puis 2... puis 6 !",
		"Bonne chance pour ta fuite !"
	])
	
	# On remet l'animation au repos après 4 secondes
	get_tree().create_timer(6.0).timeout.connect(func(): anim.play("idle"))
