extends TileMap

onready var KillNode = preload("res://Tiles/KillNode.tscn")
onready var DestroyNode = preload("res://Tiles/DestroyNode.tscn")
onready var WinNode = preload("res://Tiles/Level Win.tscn")
onready var CheckpointNode = preload("res://Tiles/Checkpoint.tscn")
onready var OvenNode = preload("res://Tiles/Oven.tscn")
onready var FlamethrowerNode = preload("res://Tiles/FlameThrower.tscn")

export(int) var killID = 1
export(int) var destroyID = 2
export(int) var winID = 3
export(String, FILE, "*.tscn") var nextLevel = "res://Levels/Level.tscn"
export(int) var checkpointId = 4
export(int) var ovenId = 5
export(int) var flamethrowerId = 6

# Called when the node enters the scene tree for the first time.
func _ready():
	replace_tiles(killID, KillNode)
	replace_tiles(destroyID, DestroyNode)
	for winNode in replace_tiles(winID, WinNode):
		winNode.nextLevel = nextLevel
	replace_tiles(checkpointId, CheckpointNode)
	replace_tiles(ovenId, OvenNode)
	replace_tiles(flamethrowerId,FlamethrowerNode,true)

func replace_tiles(id, packedNode, preserveRotation = false):
	var hurts = get_used_cells_by_id(id)
	var nodes = []
	for hurt in hurts:
		var node = packedNode.instance()
		get_tree().current_scene.call_deferred("add_child", node)
		var pos = map_to_world(hurt)
		#fix upper left offset
		pos += Vector2.ONE*(cell_size/2)
		node.global_position = pos
		node.get_child(0).texture = tile_set.tile_get_texture(id)
		if preserveRotation:
			pass
		set_cellv(hurt,-1)
		nodes.push_back(node)
	return nodes
