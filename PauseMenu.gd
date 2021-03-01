extends CanvasLayer

onready var popup = $Popup
onready var order = $Order
onready var orderAnimation = $Order/AnimationPlayer
onready var timer = $Order/Timer
onready var nameText = $Popup/Label

var paused = false

func _ready():
	nameText.text = get_tree().current_scene.name

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	paused = !paused
	if paused:
		popup.popup()
		if orderAnimation.current_animation != "Start":
			orderAnimation.play("Start")
		timer.disconnect("timeout",order,"on_Timer_timeout")
	else:
		popup.visible = false
		orderAnimation.play("End")
