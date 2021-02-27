extends KinematicBody2D

signal death

onready var MeatBall = load("res://DeadMeat.tscn")

export(float) var acceleration = 100
export(float) var maxSpeed = 300
export(float) var gravity = 9.8
export(float) var jumpHeight = 10
var velocity = Vector2.ZERO

var checkpoint = Vector2.ZERO

func set_checkpoint(point):
	checkpoint = point

func _physics_process(_delta):
	var inputVector = Vector2.ZERO
	inputVector.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * acceleration
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		velocity.y -= jumpHeight * gravity
	else:
		inputVector.y += gravity
	
	velocity += inputVector
	velocity.x = lerp(clamp(velocity.x,-maxSpeed,maxSpeed),0,.1)
	velocity = move_and_slide(velocity,Vector2.UP)

func _on_HurtBox_body_entered(body):
	var deadMeat = MeatBall.instance()
	var main = get_tree().current_scene
	main.add_child(deadMeat)
	deadMeat.global_position = global_position
	global_position = checkpoint

func _on_DestroyBox_body_entered(body):
	global_position = checkpoint
