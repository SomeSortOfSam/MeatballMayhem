extends KinematicBody2D

export(float) var speed = 100
export(float) var gravity = 10
export(float) var jumpHeight = 20
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += gravity
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if is_on_floor() && Input.is_action_just_pressed("ui_up"):
		inputVector.y -= jumpHeight
	
	if inputVector != Vector2.ZERO:
		velocity += inputVector * speed
	else:
		velocity.x = lerp(0,velocity.x,.9)
	
	velocity = move_and_slide(velocity, Vector2.UP)
