extends CanvasLayer

var entered_code = ""
const SECRET_CODE = "0426" # Code secret pour déverrouiller la porte

func _ready():
	$EcranCode.text = "ENTREZ LE CODE : "
	
	# On génère un pavé numérique (Touches 0 à 9)
	for i in range(10):
		var btn = Button.new()
		btn.text = str(i)
		btn.custom_minimum_size = Vector2(60, 60)
		
		# Petit calcul pour les placer en grille (3 colonnes)
		var col = i % 3
		var row = i / 3
		btn.position = Vector2(400 + col * 80, 200 + row * 80)
		
		# On connecte le bouton à notre fonction de saisie
		btn.pressed.connect(self._on_digit_pressed.bind(str(i)))
		add_child(btn)
		
	# --- BOUTON VALIDER ---
	var btn_val = Button.new()
	btn_val.text = "VALIDER"
	btn_val.position = Vector2(400, 500)
	btn_val.custom_minimum_size = Vector2(100, 60)
	btn_val.pressed.connect(self._on_validate_pressed)
	add_child(btn_val)

	# --- BOUTON RETOUR (ANNULER) ---
	var btn_back = Button.new()
	btn_back.text = "RETOUR"
	# Positionné à droite du bouton VALIDER
	btn_back.position = Vector2(520, 500) 
	btn_back.custom_minimum_size = Vector2(100, 60)
	# Couleur légèrement rosée pour le différencier
	btn_back.modulate = Color.LIGHT_CORAL 
	btn_back.pressed.connect(self._on_back_pressed)
	add_child(btn_back)

func _on_digit_pressed(digit):
	if entered_code.length() < 4:
		entered_code += digit
		$EcranCode.text = "CODE : " + entered_code

func _on_validate_pressed():
	if entered_code == SECRET_CODE:
		$EcranCode.text = "ACCÈS AUTORISÉ"
		$EcranCode.modulate = Color.GREEN
		
		# On appelle la fonction d'ouverture de la double porte
		get_tree().call_group("porte_finale", "open_door")
		
		# On attend 1 seconde pour laisser lire le message, puis on ferme
		get_tree().create_timer(1.0).timeout.connect(close_minigame)
	else:
		$EcranCode.text = "ERREUR"
		$EcranCode.modulate = Color.RED
		entered_code = ""
		get_tree().create_timer(1.0).timeout.connect(reset_screen)

func _on_back_pressed():
	# Si le joueur veut quitter sans entrer de code
	close_minigame()

func reset_screen():
	$EcranCode.text = "ENTREZ LE CODE : "
	$EcranCode.modulate = Color.WHITE

func close_minigame():
	# Crucial : On relance le temps du jeu avant de supprimer le menu
	get_tree().paused = false
	queue_free()
