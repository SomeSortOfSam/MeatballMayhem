extends StaticBody2D

onready var hurtbox = $Hurtbox

export(int) var tileRange = 0

func _ready():
	hurtbox.set_scale(Vector2(32,tileRange * 32))
	hurtbox.position.y = -hurtbox.scale.y - 32

func _on_Hurtbox_body_entered(body):
	body.cook()
