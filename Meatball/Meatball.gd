extends KinematicBody2D

signal death
signal new_checkpoint

export(float) var acceleration = 100
export(float) var maxSpeed = 300
export(float) var gravity = 9.8
export(float) var jumpHeight = 10
var velocity = Vector2.ZERO

onready var sprite = $AnimatedSprite
onready var saltHat = $AnimatedSprite/Salt
onready var garnishHat = $AnimatedSprite/Garnish
onready var audio = $AudioStreamPlayer2D

var cooked = false
var salted = false
var garnished = false

var paused = false

export(bool) var hasDoneDeluxeRespawn = true

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		paused = !paused
		if paused:
			set_physics_process(false)
			sprite.playing = false
		else:
			set_physics_process(true)
			sprite.playing = true

func _ready():
	set_physics_process(false)
	audio.set_stream(load("res://Sounds/Respawn.wav"))
	audio.play()
	if hasDoneDeluxeRespawn:
		animate("Respawn","post_ready")
	else:
		animate("Respawn_Deluxe","post_ready")

func post_ready():
	set_physics_process(true)
	sprite.disconnect("animation_finished", $".", "post_ready")

func set_new_checkpoint():
	emit_signal("new_checkpoint")

func _physics_process(_delta):
	var inputVector = Vector2.ZERO
	inputVector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * acceleration
	if is_on_floor():
		rotation = get_floor_normal().angle() + PI/2
		if inputVector.x != 0:
			animate("Walk")
		else:
			animate("Idel")
	else:
		rotation = 0
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		velocity.y -= jumpHeight * gravity
		animate("Jump","fall")
		audio.set_stream(load("res://Sounds/Jump.wav"))
		audio.play()
	else:
		inputVector.y += gravity
	
	velocity += inputVector
	velocity.x = lerp(clamp(velocity.x,-maxSpeed,maxSpeed),0,.1)
	velocity = move_and_slide(velocity,Vector2.UP)
	
	sprite.flip_h = velocity.x < 0

func fall():
	animate("Midair")
	sprite.disconnect("animation_finished", $".", "fall")

func kill(deathAnimation : String):
	set_physics_process(false)
	animate("Death_" + deathAnimation,"dead")
	audio.set_stream(load("res://Sounds/" + deathAnimation +".wav"))
	audio.play()

func dead():
	sprite.disconnect("animation_finished", $".", "dead")
	emit_signal("death")
	#Checkpoint should free node - remote transform dies before we can get to it otherwise
	#queue_free()

func cook():
	
	if audio is AudioStreamPlayer2D:
		audio.set_stream(load("res://Sounds/Cook.wav"))
		audio.play()
	
	if cooked:
		kill("Burn")
	else:
		cooked = true
		#change current animation to cooked state
		if sprite is AnimatedSprite:
			var animation = sprite.animation
			animation.erase(animation.length() - 9,9)
			animate(animation)

func salt():
	salted = true
	saltHat.set_visible(true)

func garnish():
	garnished = true
	garnishHat.set_visible(true)

func animate(animation : String,endFunction = ""):
	if endFunction != "":
		sprite.connect("animation_finished", $".", endFunction)
	if cooked:
		sprite.play(animation + "_Cooked")
	else:
		sprite.play(animation + "_Uncooked")
