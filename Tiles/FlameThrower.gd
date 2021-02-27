extends StaticBody2D

onready var raycast = $RayCast2D
onready var hurtboxCollision = $Hurtbox/CollisionShape2D2

export(bool) var use_timer = false
export(float) var up_time = 5
export(float) var down_time = 2

func _process(delta):
	var distance = raycast.cast_to.y
	if raycast.is_colliding():
		var point = raycast.get_collision_point()
		
		hurtboxCollision.set_self_modulate(Color.green)
		distance = point.distance_to(global_position)
	var shape = hurtboxCollision.get_shape()
	shape.set_extents(Vector2(32,distance/2 - 16))
	hurtboxCollision.set_shape(shape)
	hurtboxCollision.position.y = distance/2 - 16

func _on_Hurtbox_body_entered(body):
	body.cook()

