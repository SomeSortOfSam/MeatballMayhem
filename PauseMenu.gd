extends CanvasLayer

onready var color = $ColorRect
onready var order = $Order
onready var orderAnimation = $Order/AnimationPlayer
onready var timer = $Order/Timer

var paused = false

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	paused = !paused
	if paused:
		color.color = Color(0,0,0,.8)
		if orderAnimation.current_animation != "Start":
			orderAnimation.play("Start")
		timer.disconnect("timeout",order,"on_Timer_timeout")
	else:
		color.color = Color(0,0,0,0)
		orderAnimation.play("End")
