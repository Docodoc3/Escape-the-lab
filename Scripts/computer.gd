extends StaticBody2D

var minigame_scene = preload("res://Scenes/hacking_minigame.tscn")
var is_hacked = false

func interact(player):
	if is_hacked:
		print("Terminal en cours de redémarrage... Patientez.")
		return
		
	get_tree().paused = true
	var minigame = minigame_scene.instantiate()
	get_tree().root.add_child(minigame)
	
	is_hacked = true
	
	# On lance un chrono pour autoriser le prochain hack
	# On met 12 secondes (10s de désactivation + 2s de battement)
	get_tree().create_timer(12.0).timeout.connect(reset_terminal)

func reset_terminal():
	is_hacked = false
	print("Terminal prêt pour un nouveau piratage.")
