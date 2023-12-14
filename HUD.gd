extends CanvasLayer

@export var character : CharacterBody2D
@export var air_state : Node
@onready var LabelTime : Label = $LabelTime

var time_start
var time_now
# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = Time.get_ticks_msec()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_elapsed = Time.get_ticks_msec() - time_start
	LabelTime.text = "TIME: %02d:%02d:%02d" % [time_elapsed/60000,time_elapsed/1000%60,time_elapsed%1000/10]
