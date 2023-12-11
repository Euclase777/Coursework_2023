extends TileMap

#const N = 1
#const E = 2
#const S = 4
#const W = 8
#
#var cell_walls = {Vector2i(1, 0): E, Vector2i(-1, 0): W,Vector2i(0, 1): S, Vector2i(0, -1): N}

var tile_size = 64  # tile size (in pixels)
var width = 2  # width of map (in tiles)
var height = 1  # height of map (in tiles)

# get a reference to the map for convenience
@onready var Map = $"."

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	tile_size = tile_set.tile_size
	make_map()

var road_to_atlas={'sw':Vector2i(0,0), 'se':Vector2i(1,0), 'sn':Vector2i(2,0),
				   'nw':Vector2i(0,1), 'ne':Vector2i(1,1), 'we':Vector2i(2,1),
				   'ws':Vector2i(0,0), 'es':Vector2i(1,0), 'ns':Vector2i(2,0),
				   'wn':Vector2i(0,1), 'en':Vector2i(1,1), 'ew':Vector2i(2,1)}

var sides={'n':Vector2i(0,-1),'s':Vector2i(0,1),
		   'e':Vector2i(-1,0),'w':Vector2i(1,0)}

var roads = {}

func make_map():
	clear()
	roads = {}
	var current = Vector2i(0,0)
	roads[current]=road_to_atlas['we']
	var end = 'w'
	var start = sides.find_key(-sides[end])
	var stuck
	var set_neighbours = Array()
	for i in 100:
		current += sides[end]
		end = pick_new(start)
		stuck = 0
		while (check_neighbours(current+sides[end])>2) and (stuck < 200):
			print("stuck at ", current)
			end = pick_new(start)
			stuck+=1
		if stuck == 200:
			print("ERROR AT:", current)
		roads[current]=road_to_atlas[start+end]
		set_cell(0,current,0,roads[current])
		start = sides.find_key(-sides[end])
		

func check_neighbours(cell):
	var list = 0
	if cell in roads:
		list=3
	for n in sides.values():
		if cell+n in roads:
			list+=1
	return list

func pick_new(direction):
	var out = Array()
	for side in sides:
		if side != direction:
			out.append(side)
#		if direction != 'w':
#			out.append('w')
#		else:
#			out.append('n')
#			out.append('s')
	return out[randi()%out.size()]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("new"):
		make_map()
