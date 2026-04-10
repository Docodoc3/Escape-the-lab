extends CanvasLayer

@onready var key_icon = $KeyIcon
var key_label: Label
var hp_label: Label 
var current_hud_directive_panel: PanelContainer = null 

func _ready():
	add_to_group("hud")
	# Config Clé Bas Gauche
	key_icon.anchor_left = 0; key_icon.anchor_top = 1
	key_icon.offset_left = 20; key_icon.offset_top = -60
	key_icon.modulate = Color(0.3, 0.3, 0.3, 0.5)
	
	key_label = Label.new()
	add_child(key_label)
	key_label.text = "AUCUNE CLÉ"; key_label.anchor_left = 0; key_label.anchor_top = 1
	key_label.offset_left = 70; key_label.offset_top = -50
	
	# Config Vies Haut Droite
	hp_label = Label.new()
	add_child(hp_label)
	hp_label.anchor_left = 1; hp_label.anchor_right = 1
	hp_label.offset_left = -280; hp_label.offset_top = 20

func update_hp(hp: int):
	if hp_label: hp_label.text = "VIES : " + str(hp)

func show_key():
	key_icon.modulate = Color.WHITE
	key_label.text = "PUCE RFID : OK"
	key_label.add_theme_color_override("font_color", Color.GREEN)

func show_hud_directive(lines: Array, header: String = "DIRECTIVE :", time: float = 4.0):
	if current_hud_directive_panel: current_hud_directive_panel.queue_free()
	current_hud_directive_panel = PanelContainer.new()
	add_child(current_hud_directive_panel)
	current_hud_directive_panel.set_anchors_and_offsets_preset(Control.PRESET_CENTER_TOP)
	current_hud_directive_panel.offset_top = 20
	
	var vbox = VBoxContainer.new()
	current_hud_directive_panel.add_child(vbox)
	var h = Label.new(); h.text = header; h.modulate = Color.YELLOW; vbox.add_child(h)
	var b = Label.new(); b.text = "\n".join(lines); vbox.add_child(b)
	get_tree().create_timer(time).timeout.connect(func(): if is_instance_valid(current_hud_directive_panel): current_hud_directive_panel.queue_free())
