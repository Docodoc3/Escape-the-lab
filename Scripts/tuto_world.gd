extends Node2D

func _ready():
	await get_tree().process_frame
	var consignes = [
		"MISSION : Infiltrez le laboratoire.",
		"OBJECTIF : Récupérez la PUCE RFID pour ouvrir la porte verrouillée.",
		"INFO : Trouvez l'allié pour obtenir le code de sortie."
	]
	get_tree().call_group("hud", "show_hud_directive", consignes, "ORDRE DE MISSION :")
