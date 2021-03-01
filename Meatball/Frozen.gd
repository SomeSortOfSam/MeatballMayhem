extends KinematicBody2D

onready var sprite = $Sprite
onready var left = $Left
onready var right= $Right

export(float) var acceleration = 100
export(float) var maxSpeed = 300
export(float) var gravity = 9.8
var velocity = Vector2.ZERO
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
	var inputVector = Vector2.ZERO
	if left.is_colliding():
		inputVector.x -= acceleration
	if right.is_colliding():
		inputVector.x += acceleration
	if is_on_floor():
		rotation = get_floor_normal().angle() + PI/2
	else:
		rotation = 0
		inputVector.y += gravity
	
	velocity += inputVector
	velocity.x = lerp(clamp(velocity.x,-maxSpeed,maxSpeed),0,.1)
	velocity = move_and_slide(velocity,Vector2.UP)
	

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
