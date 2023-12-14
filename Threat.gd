extends Sprite2D

@onready var player = $"../Player"
@onready var chunkmap = $"../ChunkMap"
var chunk = Vector2i(0,0)
var target_chunk = Vector2i(1,0)
var target_position : Vector2
var danger = 0
var maxdanger = 0
@export var speed : int = 9
var spawntime

# Called when the node enters the scene tree for the first time.
func _ready():
	spawntime = Time.get_ticks_msec()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#chunk = Vector2i(((position-Vector2(160,160)) / Vector2(320,320)).round())
	if Time.get_ticks_msec()-spawntime < 5000:
		await get_tree().create_timer(15).timeout
	if player.chunk==chunk:
		target_position=player.position
		target_chunk=player.chunk
	else:
		target_position = Vector2(target_chunk)*Vector2(320,320)+Vector2(160,160)
	if (position - target_position).length()>speed:
		position+=(target_position-position).normalized()*Vector2(speed,speed)
	else:
		position = target_position
		chunk = target_chunk
		target_chunk = chunkmap.roads.keys()[chunkmap.roads.keys().find(chunk)+1]
	danger = 1/(position-player.position).length()*100
	modulate = Color.from_hsv(0,danger,1,1)
	if danger > 2:
		Events.emit_signal('game_over')
		pass
