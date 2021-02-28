extends RigidBody2D

onready var sprite = $Sprite

var cooked = false

func animate(animation : String,endFunction = ""):
	if endFunction != "":
		sprite.connect("animation_finished", $".", endFunction)
	if cooked:
		sprite.play(animation + "_Cooked")
	else:
		sprite.play(animation + "_Uncooked")

func kill():
	queue_free()

func cook():
	animate("Melt","kill")
