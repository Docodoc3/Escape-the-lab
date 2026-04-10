extends Node2D

func _ready():
	# On attend que le HUD soit prêt
	await get_tree().process_frame
	
	var consignes = [
		"MISSION : Infiltrez le complexe.",
		"OBJECTIF : Récupérez la PUCE RFID pour ouvrir la porte verrouillée.",
		"INFO : Trouvez l'allié pour obtenir le code de sortie."
	]
	# Appel du groupe HUD pour afficher les messages
	get_tree().call_group("hud", "show_hud_directive", consignes, "ORDRE DE MISSION :")
