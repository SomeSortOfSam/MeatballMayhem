extends StaticBody2D

onready var hurtboxCollision = $Hurtbox/CollisionShape2D2

export(bool) var use_timer = false
export(float) var up_time = 5
export(float) var down_time = 2

export(int) var tileRange = 0

func _ready():
	hurtboxCollision.shape.extents.y = tileRange * 32
	hurtboxCollision.position.y = -hurtboxCollision.shape.extents.y - 32

func _on_Hurtbox_body_entered(body):
	body.cook()

