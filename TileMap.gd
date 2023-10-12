extends TileMap

@export var character : CharacterBody2D

var tiles = []
#(144;81)
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 72:
		for j in 5:
			tiles.append(Vector2i(i*2,j*2))
			tiles.append(Vector2i(i*2+1,j*2))
			tiles.append(Vector2i(i*2,j*2+1))
			tiles.append(Vector2i(i*2+1,j*2+1))
		
		tiles.append(Vector2i(i*2,80))
		tiles.append(Vector2i(i*2+1,80))
		tiles.append(Vector2i(i*2,81))
		tiles.append(Vector2i(i*2+1,81))
	for i in 72:
		for j in 40:
			if randi_range(1,100)<6:
				tiles.append(Vector2i(i*2,j*2))
				tiles.append(Vector2i(i*2+1,j*2))
				tiles.append(Vector2i(i*2,j*2+1))
				tiles.append(Vector2i(i*2+1,j*2+1))
	
	# set_cells_terrain_connect(0,tiles,0,0,true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if get_cell_tile_data(0,get_coords_for_body_rid(character) / Vector2i(8,8)) != null:
#		character.position.y -= 100 * character.direction.y
#		character.position.x -= 100 * character.direction.x
	pass
