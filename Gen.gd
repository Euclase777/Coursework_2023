@tool
extends TileMap

var tiles = []
var patterns = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 6:
		tiles = []
		for x in 80:
			for y in 80:
				tiles.append(Vector2i(x,y+80*i))
		patterns.append(get_pattern(0,tiles))
		print(patterns[i])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
