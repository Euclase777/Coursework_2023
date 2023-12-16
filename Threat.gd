extends Sprite2D

@onready var player = $"../Player"
@onready var chunkmap = $"../ChunkMap"
var chunk = Vector2i(0,0)
var target_chunk = Vector2i(1,0)
var target_position : Vector2
var danger = 0
var maxdanger = 0
@export var speed : int = 550
var spawntime

# Called when the node enters the scene tree for the first time.
func _ready():
	spawntime = Time.get_ticks_msec()
	Events.erase_chunk.connect(self._on_Events_erase_chunk)

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
	if (position - target_position).length()>speed*delta:
		position+=(target_position-position).normalized()*Vector2(speed,speed)*delta
	else:
		position = target_position
		chunk = target_chunk
		target_chunk = chunkmap.roads.keys()[chunkmap.roads.keys().find(chunk)+1]
	danger = 1/(position-player.position).length()*100
	modulate = Color.from_hsv(0,danger,1,1)
	if danger > 2:
		Events.emit_signal('game_over')
		pass
	if (chunkmap.roads.keys().find(player.chunk)-chunkmap.roads.keys().find(chunk))>7:
		speed = 2500
	elif player.position.y<position.y:
		speed = 530
	else:
		speed = 550
	if Vector2i(target_chunk-chunk).length()>1:
		position = target_position
		chunk = target_chunk
		target_chunk = chunkmap.roads.keys()[chunkmap.roads.keys().find(chunk)+1]
		
func _on_Events_erase_chunk(chunk):
	pass
