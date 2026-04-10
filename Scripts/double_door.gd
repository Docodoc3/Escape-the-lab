extends StaticBody2D

func _ready():
	# On s'assure que la porte affiche l'animation fermée au lancement
	$AnimatedSprite2D.play("closed")

func open_door():
	$AnimatedSprite2D.play("open")
	$CollisionShape2D.set_deferred("disabled", true)
	print("La double porte s'ouvre lourdement...")
