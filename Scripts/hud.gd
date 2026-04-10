extends CanvasLayer

@onready var key_icon = $KeyIcon
var key_label: Label
var hp_label: Label 
var current_hud_directive_panel: PanelContainer = null 

func _ready():
	add_to_group("hud")
	
	# --- CONFIG CLÉ (Bas Gauche) ---
	key_icon.anchor_left = 0
	key_icon.anchor_top = 1
	key_icon.anchor_right = 0
	key_icon.anchor_bottom = 1
	key_icon.offset_left = 20
	key_icon.offset_bottom = -20
	key_icon.offset_right = 60
	key_icon.offset_top = -60
	key_icon.modulate = Color(0.3, 0.3, 0.3, 0.5)

	key_label = Label.new()
	add_child(key_label)
	key_label.text = "AUCUNE CLÉ"
	key_label.anchor_left = 0
	key_label.anchor_top = 1
	key_label.anchor_right = 0
	key_label.anchor_bottom = 1
	key_label.offset_left = 70
	key_label.offset_bottom = -20
	key_label.offset_top = -60
	key_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	key_label.add_theme_color_override("font_color", Color(1, 1, 1, 0.5))
	
	# --- CONFIG VIES (Haut Droite) ---
	hp_label = Label.new()
	add_child(hp_label)
	hp_label.anchor_left = 1 
	hp_label.anchor_right = 1
	hp_label.offset_left = -280
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

func show_hud_directive(lines: Array, header_text: String = "DIRECTIVE :", display_time: float = 6.0):
	if current_hud_directive_panel and is_instance_valid(current_hud_directive_panel):
		current_hud_directive_panel.queue_free()

	current_hud_directive_panel = PanelContainer.new()
	add_child(current_hud_directive_panel)
	current_hud_directive_panel.anchor_left = 0
	current_hud_directive_panel.anchor_top = 0
	current_hud_directive_panel.anchor_right = 1
	current_hud_directive_panel.offset_left = 10  
	current_hud_directive_panel.offset_right = -10 
	current_hud_directive_panel.offset_top = 10   
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.05, 0.05, 0.07, 0.9) 
	style.border_width_top = 3
	style.border_color = Color(0, 1, 1, 0.8) 
	style.content_margin_left = 15
	style.content_margin_top = 10
	style.content_margin_bottom = 10
	current_hud_directive_panel.add_theme_stylebox_override("panel", style)

	var text_vbox = VBoxContainer.new()
	current_hud_directive_panel.add_child(text_vbox)
	var header_label = Label.new()
	header_label.text = header_text
	header_label.add_theme_color_override("font_color", Color(1, 1, 0)) 
	text_vbox.add_child(header_label)
	var body_label = Label.new()
	body_label.text = "\n".join(lines)
	text_vbox.add_child(body_label)

	get_tree().create_timer(display_time).timeout.connect(func(): 
		if is_instance_valid(current_hud_directive_panel):
			current_hud_directive_panel.queue_free()
	)
