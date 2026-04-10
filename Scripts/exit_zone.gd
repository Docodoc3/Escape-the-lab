extends Area2D

func _on_body_entered(body):
	print("🚨 DÉTECTION : Quelque chose a touché la zone ! C'est : ", body.name)
	# Vérifie si le corps qui est entré appartient au groupe "player"
	if body.is_in_group("player"):
		print("Victoire !")
		get_tree().change_scene_to_file("res://Scenes/victory_screen.tscn")
