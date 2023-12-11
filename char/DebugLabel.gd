extends Label

@onready var character : CharacterBody2D = $".."
@export var state_machine : CharacterStateMachine
@export var air_state : State

@onready var wallcheck : RayCast2D = $"../WallJumpCheck"

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		visible = not visible
	text = "State : " + state_machine.current_state.name 
	text += "\nDouble Jumps: " + str(air_state.double_jumps) 
	text += "\n Dashes: " + str(air_state.air_dashes)
	text += "\n" + str(character.block)
	text += "\n" + str(character.chunk)
