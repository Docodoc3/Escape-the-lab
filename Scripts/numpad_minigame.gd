extends CanvasLayer

var entered_code = ""
const SECRET_CODE = "0426" # Change ça par le code que tu veux !

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
		
		# On connecte le bouton à notre fonction
		btn.pressed.connect(self._on_digit_pressed.bind(str(i)))
		add_child(btn)
		
	# Bouton VALIDER
	var btn_val = Button.new()
	btn_val.text = "VALIDER"
	btn_val.position = Vector2(400, 500)
	btn_val.pressed.connect(self._on_validate_pressed)
	add_child(btn_val)

func _on_digit_pressed(digit):
	print("Bouton cliqué : ", digit)
	if entered_code.length() < 4:
		entered_code += digit
		$EcranCode.text = "CODE : " + entered_code

func _on_validate_pressed():
	if entered_code == SECRET_CODE:
		$EcranCode.text = "ACCÈS AUTORISÉ"
		$EcranCode.modulate = Color.GREEN
		
		# ON OUVRE LA PORTE !
		get_tree().call_group("porte_finale", "open_door")
		
		# On attend 1 seconde puis on ferme le mini-jeu
		get_tree().create_timer(1.0).timeout.connect(close_minigame)
	else:
		$EcranCode.text = "ERREUR"
		$EcranCode.modulate = Color.RED
		entered_code = ""
		get_tree().create_timer(1.0).timeout.connect(reset_screen)

func reset_screen():
	$EcranCode.text = "ENTREZ LE CODE : "
	$EcranCode.modulate = Color.WHITE

func close_minigame():
	get_tree().paused = false
	queue_free()
