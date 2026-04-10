extends CanvasLayer

var current_target = 1

func _ready():
	# On crée 5 boutons placés aléatoirement sur l'écran
	for i in range(1, 6):
		var btn = Button.new()
		btn.text = str(i)
		btn.custom_minimum_size = Vector2(80, 80) # Taille des boutons
		
		# Position aléatoire (adapte les chiffres selon la taille de ton écran)
		var random_x = randf_range(200, 900)
		var random_y = randf_range(150, 500)
		btn.position = Vector2(random_x, random_y)
		
		# On connecte le clic du bouton à notre fonction de vérification
		btn.pressed.connect(self._on_button_pressed.bind(btn, i))
		
		# On ajoute le bouton à l'écran
		add_child(btn)

func _on_button_pressed(btn, number):
	if number == current_target:
		# Bon bouton cliqué !
		btn.disabled = true
		btn.modulate = Color.GREEN # Le bouton devient vert
		current_target += 1
		
		if current_target > 5:
			win_game()
	else:
		# Mauvais bouton ! On réinitialise tout (Erreur Fatale)
		print("Erreur de séquence !")
		current_target = 1
		for child in get_children():
			if child is Button:
				child.disabled = false
				child.modulate = Color.WHITE

func win_game():
	print("1. Piratage réussi !")
	
	# Il faut enlever la pause AVANT d'appeler les sentinelles
	get_tree().paused = false 
	
	# On appelle le groupe
	get_tree().call_group("sentinelles", "disable")
	
	print("2. Message radio envoyé !")
	queue_free()
