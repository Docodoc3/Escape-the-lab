extends Control

func _on_button_pressed():
	# On retourne à l'écran titre
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
