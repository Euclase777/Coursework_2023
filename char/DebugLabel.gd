extends Label

@export var state_machine : CharacterStateMachine
@export var air_state : State

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("debug"):
		visible = not visible
	text = "State : " + state_machine.current_state.name + "\nDouble Jumps: " + str(air_state.double_jumps) + "\n Dashes: " + str(air_state.air_dashes)
