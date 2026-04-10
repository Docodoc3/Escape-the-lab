extends CanvasLayer

@onready var key_icon = $KeyIcon
var key_label: Label # On crée une variable pour le texte de la clé
var current_hud_directive_panel: PanelContainer = null 

func _ready():
	# 1. Configuration de l'icône de clé (en bas à gauche)
	key_icon.anchor_left = 0
	key_icon.anchor_top = 1
	key_icon.anchor_right = 0
	key_icon.anchor_bottom = 1
	key_icon.offset_left = 20
	key_icon.offset_bottom = -20
	key_icon.offset_right = 60
	key_icon.offset_top = -60
	key_icon.modulate = Color(0.3, 0.3, 0.3, 0.5) # Grisée au début

	# 2. Création dynamique du texte à côté de la clé
	key_label = Label.new()
	add_child(key_label)
	key_label.text = "AUCUNE CLÉ"
	key_label.add_theme_color_override("font_color", Color(1, 1, 1, 0.5)) # Texte grisé
	key_label.add_theme_font_size_override("font_size", 14)
	
	# Positionnement du texte juste à droite de l'icône
	key_label.anchor_left = 0
	key_label.anchor_top = 1
	key_label.anchor_right = 0
	key_label.anchor_bottom = 1
	key_label.offset_left = 70  # On le décale après l'icône (qui finit à 60)
	key_label.offset_bottom = -20
	key_label.offset_top = -60
	key_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

# --- FONCTIONS DE LA CLÉ ---

func show_key():
	# On allume l'icône
	key_icon.modulate = Color(1, 1, 1, 1)
	# On met à jour le texte
	key_label.text = "PUCE RFID : OK"
	key_label.add_theme_color_override("font_color", Color(0, 1, 0)) # Texte en vert
	print("UI: Clé activée")

func hide_key():
	# On grise l'icône
	key_icon.modulate = Color(0.3, 0.3, 0.3, 0.5)
	# On remet le texte par défaut
	key_label.text = "AUCUNE CLÉ"
	key_label.add_theme_color_override("font_color", Color(1, 1, 1, 0.5))
	print("UI: Clé retirée")

# --- LOGIQUE DU PANNEAU DE DIRECTIVES (PNJ / INTRO) ---

func show_dialogue(lines: Array):
	show_hud_directive(lines, "DIRECTIVE :", 6.0)

func show_hud_directive(lines: Array, header_text: String, display_time: float = 6.0):
	if current_hud_directive_panel and is_instance_valid(current_hud_directive_panel):
		current_hud_directive_panel.queue_free()

	current_hud_directive_panel = PanelContainer.new()
	add_child(current_hud_directive_panel)
	
	current_hud_directive_panel.anchor_left = 0
	current_hud_directive_panel.anchor_top = 0
	current_hud_directive_panel.anchor_right = 1
	current_hud_directive_panel.anchor_bottom = 0
	current_hud_directive_panel.offset_left = 10  
	current_hud_directive_panel.offset_right = -10 
	current_hud_directive_panel.offset_top = 10   
	current_hud_directive_panel.custom_minimum_size = Vector2(0, 110)

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.05, 0.05, 0.07, 0.95) 
	style.border_width_top = 3
	style.border_width_bottom = 1
	style.border_width_left = 1
	style.border_width_right = 1
	style.border_color = Color(0, 1, 1, 0.8) 
	style.content_margin_left = 15
	style.content_margin_right = 15
	style.content_margin_top = 10
	style.content_margin_bottom = 10
	current_hud_directive_panel.add_theme_stylebox_override("panel", style)

	var content_hbox = HBoxContainer.new()
	current_hud_directive_panel.add_child(content_hbox)

	var text_vbox = VBoxContainer.new()
	text_vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content_hbox.add_child(text_vbox)

	var header_label = Label.new()
	header_label.text = header_text
	header_label.add_theme_color_override("font_color", Color(1, 1, 0)) 
	header_label.add_theme_font_size_override("font_size", 18) 
	text_vbox.add_child(header_label)

	var body_label = Label.new()
	body_label.text = "\n".join(lines)
	body_label.autowrap_mode = TextServer.AUTOWRAP_WORD 
	body_label.visible_ratio = 1.0
	body_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	body_label.vertical_alignment = VERTICAL_ALIGNMENT_TOP
	body_label.add_theme_color_override("font_color", Color(1, 1, 1)) 
	body_label.add_theme_font_size_override("font_size", 16) 
	text_vbox.add_child(body_label)

	var sentry_rect = TextureRect.new()
	sentry_rect.custom_minimum_size = Vector2(100, 0)
	var sentry_texture = ImageTexture.create_from_image(_create_sentry_head_image())
	sentry_rect.texture = sentry_texture
	sentry_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	sentry_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	content_hbox.add_child(sentry_rect)

	get_tree().create_timer(display_time).timeout.connect(func(): 
		if is_instance_valid(current_hud_directive_panel):
			current_hud_directive_panel.queue_free()
	)

func _create_sentry_head_image() -> Image:
	var img = Image.create_empty(100, 80, false, Image.FORMAT_RGBA8)
	img.fill(Color(0,0,0,0)) 
	img.fill_rect(Rect2i(35, 20, 30, 40), Color(0.2, 0.2, 0.2, 1))
	img.fill_rect(Rect2i(48, 40, 4, 6), Color(0, 1, 0, 1))
	img.fill_rect(Rect2i(49, 75, 2, 5), Color(1, 0, 0, 1)) 
	return img
