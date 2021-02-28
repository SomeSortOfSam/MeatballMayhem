extends StaticBody2D

onready var platform = $CollisionShape2D
onready var hurt = $Hurtbox/CollisionShape2D
onready var endSprite = $EndSprite

#hurtbox should extend one PAST this
export(int) var tileRange = 3
var skewered = 0

export(Texture) var midSection

onready var SpriteNode = preload("res://Sprite.tscn")
var cooked = []

func _ready():
	set_collision_boxes(0)

func set_collision_boxes(numSkewered):
	skewered = numSkewered
	platform.shape.extents.y = (skewered + 1) * 32
	platform.position.y = -platform.shape.extents.y + 32
	hurt.shape.extents.y = (tileRange + 1 - skewered) * 32
	hurt.position.y = platform.position.y * 2 - hurt.shape.extents.y - 32
	endSprite.position.y = -64 - (skewered*64)
	for n in skewered:
		var midSprite = SpriteNode.instance()
		add_child(midSprite)
		midSprite.position.y = -64 - (n*64)
		midSprite.frame = 1
		if cooked[n]:
			midSprite.frame = 2
	if skewered >= tileRange:
		hurt.call_deferred("set_disabled",true)

func _on_Hurtbox_body_entered(body):
	cooked.push_back(body.cooked)
	body.kill(true)
	set_collision_boxes(skewered + 1)
