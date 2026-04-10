extends Node2D

func _ready():
	# On attend 1 petite seconde le temps que le jeu apparaisse, puis on lance le message
	get_tree().create_timer(1.0).timeout.connect(show_intro_rules)

func show_intro_rules():
	# On appelle directement ta super fonction de HUD !
	get_tree().call_group("hud", "show_hud_directive", [
		"Infiltration du complexe en cours.",
		"Règles : Évitez le champ de vision des sentinelles.",
		"Objectif : Trouvez le terminal de sortie, entrez le code secret et fuyez."
	], "DIRECTIVE INITIALE :")
