extends StaticBody2D

onready var hurtbox = $Hurtbox
onready var animator = $Hurtbox/AnimationPlayer

export(bool) var use_timer = false
export(float) var up_time = 5
export(float) var down_time = 2

export(int) var tileRange = 0

func _ready():
	hurtbox.set_scale(Vector2(32,tileRange * 32))
	hurtbox.position.y = -hurtbox.scale.y - 32

func _on_Hurtbox_body_entered(body):
	body.cook()

