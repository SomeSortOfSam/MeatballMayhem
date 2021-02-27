extends Camera2D

onready var topLeft = $Node/TopLeft
onready var bottomRight = $Node/BottomRight

func _ready():
	set_bounds(topLeft.position,bottomRight.position)

func set_bounds(topleftPos,bottomRightPos):
	topLeft.position = topleftPos
	bottomRight.position = bottomRightPos
	update_bounds()

func update_bounds():
	limit_top = topLeft.position.y
	limit_bottom = bottomRight.position.y 
	limit_right = bottomRight.position.x
	limit_left = topLeft.position.x
