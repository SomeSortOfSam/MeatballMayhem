extends StaticBody2D

onready var raycast = $RayCast2D
onready var hurtboxCollision = $Hurtbox/CollisionShape2D2

export(bool) var use_timer = false
export(float) var up_time = 5
export(float) var down_time = 2

func _ready():
	raycast.force_raycast_update()
	var point = raycast.cast_to
	if raycast.is_colliding():
		point = raycast.get_collision_point() - global_position
		point.rotate(rotation)
	var shape = hurtboxCollision.get_shape()
	shape.set_extents(Vector2(32,point.y))
	hurtboxCollision.set_shape(shape)
	hurtboxCollision.position.y += point.y/2 + 16

func _on_Hurtbox_body_entered(body):
	body.cook()

