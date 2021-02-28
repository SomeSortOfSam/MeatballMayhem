extends StaticBody2D

onready var platform = $CollisionShape2D
onready var hurt = $Hurtbox/CollisionShape2D
onready var endSprite = $EndSprite
onready var animationMidSprite = $MidSprite
onready var numbers = $Numbers

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
	
	hurt.shape.extents.y = (tileRange - skewered) * 32 + 11
	hurt.position.y = platform.position.y * 2 - hurt.shape.extents.y - 32
	
	animationMidSprite.scale.x = 0
	animationMidSprite.position.y =  -32
	
	endSprite.position.y = -64 - (skewered*64)
	
	#make the meat platforms
	for n in skewered:
		var midSprite = SpriteNode.instance()
		add_child(midSprite)
		midSprite.position.y = -64 - (n*64)
		midSprite.frame = 1
		if cooked[n]:
			midSprite.frame = 2
	
	numbers.rotation = -rotation
	var n = tileRange - skewered
	if n < 1:
		n = 9
	else:
		n -= 1
	numbers.frame = n
	
	#turn off kebab if at maxium range
	if skewered >= tileRange:
		hurt.call_deferred("set_disabled",true)

func _on_Hurtbox_body_entered(body):
	#Animation
	endSprite.position.y = -64 - (tileRange*64)
	animationMidSprite.scale.x = tileRange
	animationMidSprite.position.y = -(animationMidSprite.scale.x*32) - 32
	
	#Kill the player
	cooked.push_back(body.cooked)
	body.kill("Kebab")
	if rotation_degrees == 90 || rotation_degrees == 270:
		body.global_position.y = global_position.y
	else:
		body.global_position.x = global_position.x
	body.sprite.connect("animation_finished", $".", "extend_kebab")

func extend_kebab():
	set_collision_boxes(skewered + 1)
	
