extends CanvasLayer

@onready var key_icon = $KeyIcon
var key_label: Label
var hp_label: Label 
var current_hud_directive_panel: PanelContainer = null 

func _ready():
	# Config clé
	key_icon.anchor_left = 0
	key_icon.anchor_top = 1
	key_icon.modulate = Color(0.3, 0.3, 0.3, 0.5)

	key_label = Label.new()
	add_child(key_label)
	key_label.text = "AUCUNE CLÉ"
	key_label.anchor_left = 0
	key_label.anchor_top = 1
	key_label.offset_left = 70
	
	# --- CONFIGURATION LABEL VIES ---
	hp_label = Label.new()
	add_child(hp_label)
	hp_label.anchor_left = 1 
	hp_label.anchor_right = 1
	hp_label.offset_left = -280 # Décalé vers la gauche pour bien voir "VIES : X"
	hp_label.offset_top = 20
	hp_label.add_theme_font_size_override("font_size", 24)

func update_hp(hp_value: int):
	if hp_label == null: return
	hp_label.text = "VIES : " + str(hp_value)
	if hp_value <= 1:
		hp_label.add_theme_color_override("font_color", Color.RED)
	else:
		hp_label.add_theme_color_override("font_color", Color.CYAN)

func show_key():
	key_icon.modulate = Color(1, 1, 1, 1)
	key_label.text = "PUCE RFID : OK"
	key_label.add_theme_color_override("font_color", Color(0, 1, 0))

func hide_key():
	key_icon.modulate = Color(0.3, 0.3, 0.3, 0.5)
	key_label.text = "AUCUNE CLÉ"
	key_label.add_theme_color_override("font_color", Color(1, 1, 1, 0.5))
