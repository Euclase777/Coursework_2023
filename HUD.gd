extends CanvasLayer

@export var character : CharacterBody2D
@export var threat : Sprite2D
@onready var LabelTime = $LabelTime
@onready var LabelDebug = $LabelDebug
@onready var LabelScore = $LabelScore
@onready var LabelAdd = $LabelAdd

var time_start
var time_now
var score = 0
var temp_score = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = Time.get_ticks_msec()
	Events.load_chunk.connect(self._on_Events_load_chunk)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_elapsed = Time.get_ticks_msec() - time_start
	LabelTime.text = "TIME: %02d:%02d:%02d" % [time_elapsed/60000,time_elapsed/1000%60,time_elapsed%1000/10]
	if Input.is_action_just_pressed("debug"):
		LabelDebug.visible = not LabelDebug.visible
	LabelDebug.text='THREAT CHUNK:'+str(threat.chunk)
	LabelDebug.text+='\nTARGET CHUNK:'+str(threat.target_chunk)
	LabelDebug.text+='\nTHREAT SPEED:'+str(threat.speed)
	score -=1
	LabelScore.text='SCORE: '+str(score)
	LabelAdd.position.x=LabelScore.position.x+LabelScore.size.x-LabelAdd.size.x
	if LabelAdd.position.y>LabelScore.position.y:
		LabelAdd.modulate += Color(1,1,1,-0.02)
		LabelAdd.position.y -= 0.75
	
func ReloadLabelAdd():
	if LabelAdd.position.y>LabelScore.position.y:
		temp_score += 100
	else:
		temp_score = 100
	LabelAdd.text = '+'+str(temp_score)
	LabelAdd.position.y=96
	LabelAdd.modulate = Color(1,1,1,1)

	
func _on_Events_load_chunk(chunk,type):
	score+=100
	ReloadLabelAdd()
