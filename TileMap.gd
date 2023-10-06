extends TileMap

@onready var tilemap = $TileMap
var tiles = []
#(144;81)
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 72:
		for j in 40:
			if randi_range(0,5)==5:
				tiles.append(Vector2i(i*2,j*2))
				tiles.append(Vector2i(i*2+1,j*2))
				tiles.append(Vector2i(i*2,j*2+1))
				tiles.append(Vector2i(i*2+1,j*2+1))
	set_cells_terrain_connect(0,tiles,0,0,true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
