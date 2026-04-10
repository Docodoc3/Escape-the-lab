extends CharacterBody2D

const SPEED = 150.0
var has_key: bool = false
var max_hp: int = 3
var current_hp: int = 3

@onready var anim = $AnimatedSprite2D

func _ready():
	add_to_group("player")
	# Mise à jour initiale des PV via le HUD
	get_tree().call_group("hud", "call_deferred", "update_hp", current_hp)

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * SPEED
	if direction != Vector2.ZERO:
		anim.play("run")
		if direction.x != 0:
			anim.flip_h = direction.x < 0
	else:
		anim.play("idle")
	move_and_slide()

func take_damage():
	current_hp -= 1
	get_tree().call_group("hud", "update_hp", current_hp)
	if current_hp <= 0:
		die()
	else:
		var tween = create_tween()
		tween.tween_property(anim, "modulate", Color.RED, 0.1)
		tween.tween_property(anim, "modulate", Color.WHITE, 0.1)

func die():
	get_tree().paused = true
	show_game_over_screen()

func show_game_over_screen():
	var canvas = CanvasLayer.new()
	canvas.process_mode = Node.PROCESS_MODE_ALWAYS 
	get_tree().root.add_child(canvas)
	
	var rect = ColorRect.new()
	rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	rect.color = Color(0, 0, 0, 0.85)
	canvas.add_child(rect)
	
	var label = Label.new()
	label.text = "MISSION ÉCHOUÉE"
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.set_anchors_and_offsets_preset(Control.PRESET_CENTER_TOP)
	label.offset_top = 200
	label.add_theme_font_size_override("font_size", 45)
	label.add_theme_color_override("font_color", Color.RED)
	canvas.add_child(label)
	
	var btn_retry = Button.new()
	btn_retry.text = "RECOMMENCER"
	btn_retry.custom_minimum_size = Vector2(250, 60)
	btn_retry.position = Vector2(450, 350)
	btn_retry.pressed.connect(func(): 
		get_tree().paused = false
		get_tree().reload_current_scene()
		canvas.queue_free()
	)
	canvas.add_child(btn_retry)
	
	var btn_quit = Button.new()
	btn_quit.text = "QUITTER"
	btn_quit.custom_minimum_size = Vector2(250, 60)
	btn_quit.position = Vector2(450, 450)
	btn_quit.pressed.connect(func():
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
		canvas.queue_free()
	)
	canvas.add_child(btn_quit)

func _input(event):
	if event.is_action_pressed("interact"):
		var targets = $InteractionArea.get_overlapping_areas()
		for target in targets:
			if target.has_method("interact"):
				target.interact(self)
				break
			elif target.get_parent().has_method("interact"):
				target.get_parent().interact(self)
				break
