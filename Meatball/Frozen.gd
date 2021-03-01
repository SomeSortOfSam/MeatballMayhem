extends RigidBody2D

onready var sprite = $Sprite

var cooked = false

var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		paused = !paused
		if paused:
			set_physics_process(false)
			sprite.playing = false
		else:
			set_physics_process(true)
			sprite.playing = true

func _physics_process(_delta):
	pass

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
