extends Control

func _on_button_pressed():
	# Quand on clique, on charge le niveau !
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
