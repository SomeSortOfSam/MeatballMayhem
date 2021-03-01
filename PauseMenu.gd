extends CanvasLayer

onready var color = $ColorRect
onready var orderAnimation = $Order/AnimationPlayer

var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	paused = !paused
	if paused:
		color.color = Color(0,0,0,.8)
		orderAnimation.play("Start")
	else:
		color.color = Color(0,0,0,0)
		orderAnimation.play("End")
