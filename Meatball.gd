extends KinematicBody2D

export(float) var speed = 10
var velocity = Vector2.ZERO

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	inputVector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if inputVector != Vector2.ZERO:
		velocity = inputVector * speed
	else:
		velocity = Vector2.ZERO
	
	move_and_collide(velocity)
