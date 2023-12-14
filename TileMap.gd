extends TileMap

@onready var character : CharacterBody2D = $"../Player"
@onready var chunkmap : TileMap = $"../ChunkMap"
const chunk_size = 80 
var tiles = []
var patterns = []
var type_to_pattern={}
# Called when the node enters the scene tree for the first time.
func _ready():
	Events.load_chunk.connect(self._on_Events_load_chunk)
	Events.error_chunk.connect(self._on_Events_error_chunk)
	for i in 6:
		tiles = []
		for x in chunk_size:
			for y in chunk_size:
				if get_cell_tile_data(0,Vector2i(x,y+chunk_size*i)) != null:
					tiles.append(Vector2i(x,y+chunk_size*i))
					set_cell(0,Vector2i(x,y+chunk_size*i),-1)
		patterns.append(get_pattern(0,tiles))
	type_to_pattern={Vector2i(0,0):patterns[4], Vector2i(1,0):patterns[2], Vector2i(2,0):patterns[1],
					 Vector2i(0,1):patterns[3], Vector2i(1,1):patterns[5], Vector2i(2,1):patterns[0]}

func _on_Events_load_chunk(chunk, type):
	print(chunk,' generating at ',Time.get_ticks_msec())
	tiles = type_to_pattern[type].get_used_cells()
	for i in len(tiles):
		tiles[i]+=chunk_size*chunk
	print('Tiles array done at ',Time.get_ticks_msec())
	set_cells_terrain_connect(0,tiles,0,0)
	print('Tiles done at ',Time.get_ticks_msec())



func _on_Events_error_chunk(chunk):
	for x in chunk_size:
		for y in chunk_size:
			erase_cell(0,Vector2i(x,y)+chunk_size*chunk)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
