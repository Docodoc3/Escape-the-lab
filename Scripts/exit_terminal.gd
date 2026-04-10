extends StaticBody2D

var numpad_scene = preload("res://Scenes/numpad_minigame.tscn")
var is_opened = false

func interact(player):
	if is_opened:
		return
		
	get_tree().paused = true
	var minigame = numpad_scene.instantiate()
	get_tree().root.add_child(minigame)
	is_opened = true
