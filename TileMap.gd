extends TileMap

@onready var character : CharacterBody2D = $"../Player"
@onready var chunkmap : TileMap = $"../ChunkMap"

var tiles = []
var patterns = []
var type_to_pattern={}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.load_chunk.connect(self._on_Events_load_chunk)
	for i in 6:
		tiles = []
		for x in 80:
			for y in 80:
				tiles.append(Vector2i(x,y+80*i))
				set_cell(0,Vector2i(x,y+80*i),-1)
		patterns.append(get_pattern(0,tiles))
	type_to_pattern={Vector2i(0,0):patterns[4], Vector2i(1,0):patterns[2], Vector2i(2,0):patterns[1],
					 Vector2i(0,1):patterns[3], Vector2i(1,1):patterns[5], Vector2i(2,1):patterns[0]}
	print('patterns created succesfully')

func _on_Events_load_chunk(chunk, type):
	tiles = []
	for x in 80:
		for y in 80:
			if type_to_pattern[type].has_cell(Vector2i(x,y)):
				tiles.append(Vector2i(x+80*chunk.x,y+80*chunk.y))
	set_cells_terrain_connect(0,tiles,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
