extends TileMap

onready var KillNode = preload("res://Tiles/Spikes.tscn")
onready var DestroyNode = preload("res://Tiles/Grinder.tscn")
onready var WinNode = preload("res://Tiles/Level Win.tscn")
onready var CheckpointNode = preload("res://Tiles/Checkpoint.tscn")
onready var OvenNode = preload("res://Tiles/Oven.tscn")
onready var FlamethrowerNode = preload("res://Tiles/FlameThrower.tscn")
onready var KebabHeadNode = preload("res://Tiles/Kebab.tscn")

export(int) var killID = 2
export(float, 0, 1) var flipPercent = .3
export(int) var destroyID = 5
export(int) var winID = 4
export(String, FILE, "*.tscn") var nextLevel = "res://Levels/Level.tscn"
export(int) var checkpointId = 3
export(int) var ovenId = 6
export(int) var flamethrowerId = 9
export(int) var flameId = 10
export(int) var kebabHeadId = 11
export(int) var kebabSpikeId = 12

var markers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	for spike in replace_tiles(killID, KillNode):
		if rand.randf_range(0,1) <= flipPercent:
			spike.get_node("Sprite").flip_h = true
	
	replace_tiles(destroyID, DestroyNode)
	
	for winNode in replace_tiles(winID, WinNode):
		winNode.nextLevel = nextLevel
	
	replace_tiles(checkpointId, CheckpointNode)
	
	replace_tiles(ovenId, OvenNode)
	
	replace_tiles_with_length_value(flamethrowerId,FlamethrowerNode,flameId)
	
	replace_tiles_with_length_value(kebabHeadId,KebabHeadNode,kebabSpikeId)
	
	clear_marker_tiles()


func replace_tiles(id, packedNode, preserveRotation = false):
	var cells = get_used_cells_by_id(id)
	var nodes = []
	for cell in cells:
		var node = packedNode.instance()
		get_tree().current_scene.call_deferred("add_child", node)
		var pos = map_to_world(cell)
		#fix upper left offset
		pos += Vector2.ONE*(cell_size/2)
		
		node.global_position = pos
		
		if preserveRotation:
			node.rotate(get_cell_rotation(cell))
		elif is_cell_x_flipped(cell.x,cell.y):
			node.get_node("Sprite").set_flip_h(true)
		
		markers.push_back(cell)
		nodes.push_back(node)
	return nodes

#90: transpose and flip x. 180: flip x and flip y. 270: transpose and flip y.
func get_cell_rotation(cell):
	var rotation = 0
	if is_cell_y_flipped(cell.x,cell.y):
		rotation += PI
	if is_cell_transposed(cell.x,cell.y):
		rotation += PI/2
	return rotation


func replace_tiles_with_length_value(headId, headNode, limbId):
	var nodes = replace_tiles(headId, headNode, true)
	for node in nodes:
		var pos = world_to_map(node.global_position)
		var angle = node.get_rotation()
		var direction = Vector2(sin(angle), -cos(angle))
		node.tileRange = 0
		pos += direction
		while get_cellv(pos) == limbId:
			node.tileRange += 1
			markers.push_back(pos)
			pos += direction
	return nodes

func clear_marker_tiles():
	for cell in markers:
		set_cellv(cell,-1)
