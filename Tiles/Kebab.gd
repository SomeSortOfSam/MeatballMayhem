extends StaticBody2D

onready var platform = $CollisionShape2D
onready var hurt = $Hurtbox/CollisionShape2D

#hurtbox should extend one PAST this
export(int) var tileRange = 3
var skewered = 0

func _ready():
	set_collision_boxes(0)

func set_collision_boxes(numSkewered):
	platform.shape.extents.y = (numSkewered + 1) * 32
	platform.position.y = platform.shape.extents.y
	hurt.shape.extents.y = (tileRange + 1 - numSkewered) *32
	hurt.position.y = platform.position.y * 2 + hurt.shape.extents.y
	skewered = numSkewered

func _on_Hurtbox_body_entered(body):
	body.kill()
	set_collision_boxes(skewered + 1)
