extends Node2D

func _ready():
	# On attend une image pour s'assurer que le HUD est prêt
	await get_tree().process_frame
	
	# Envoi des consignes initiales au groupe HUD
	var consignes = [
		"Infiltration du complexe en cours.",
		"Objectif : Trouvez la puce RFID pour déverrouiller la sortie.",
		"Attention : Évitez le champ de vision des sentinelles."
	]
	get_tree().call_group("hud", "show_hud_directive", consignes, "ORDRE DE MISSION :")
