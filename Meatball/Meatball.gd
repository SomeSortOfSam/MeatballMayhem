extends KinematicBody2D

signal death
signal new_checkpoint

export(float) var acceleration = 100
export(float) var maxSpeed = 300
export(float) var gravity = 9.8
export(float) var jumpHeight = 10
var velocity = Vector2.ZERO

onready var animatior = $Sprite/AnimationPlayer
onready var sprite = $Sprite

var cooked = false

func set_new_checkpoint():
	emit_signal("new_checkpoint")

func _physics_process(_delta):
	var inputVector = Vector2.ZERO
	inputVector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * acceleration
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		velocity.y -= jumpHeight * gravity
		animate("Jump")
		animatior.connect("animation_finished", $".", "fall")
	else:
		inputVector.y += gravity
	
	velocity += inputVector
	velocity.x = lerp(clamp(velocity.x,-maxSpeed,maxSpeed),0,.1)
	velocity = move_and_slide(velocity,Vector2.UP)
	
	sprite.flip_h = velocity.x <= 0

func fall(_jump):
	animate("Midair")
	animatior.disconnect("animation_finished", $".", "fall")

func land():
	animate("Idel")

func kill(keep):
	emit_signal("death")
	if keep:
		animate("Death_Spike")
	else:
		animate("Death_Saw")
	#Checkpoint should free node - remote transform dies before we can get to it otherwise
	#queue_free()

func cook():
	if cooked:
		kill(false)
	else:
		cooked = true

func animate(animation):
	if cooked:
		animatior.play(animation + "_cooked")
	else:
		animatior.play(animation + "_Uncooked")
