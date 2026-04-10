extends CanvasLayer

var current_target = 1

func _ready():
	for i in range(1, 6):
		var btn = Button.new()
		btn.text = str(i)
		btn.position = Vector2(randf_range(200, 900), randf_range(150, 500))
		btn.pressed.connect(self._on_button_pressed.bind(btn, i))
		add_child(btn)

func _on_button_pressed(btn, number):
	if number == current_target:
		btn.modulate = Color.GREEN
		current_target += 1
		if current_target > 5:
			win_game()
	else:
		current_target = 1 # Reset si erreur

func win_game():
	get_tree().paused = false 
	get_tree().call_group("hud", "show_hud_directive", [
		"Piratage OK : sentinelles désactivées pendant 10 secondes."
	], "CYBER-ATTAQUE :", 5.0)
	
	get_tree().call_group("sentinelles", "disable")
	queue_free()
