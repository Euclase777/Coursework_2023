extends State

class_name GroundState

@export var air_state : State
@export var dash_state : State
@export var blink_state : State
@export var jump_velocity : float = -500.0
@export var can_dash : bool = true
@export var can_blink : bool = true

func on_enter():
	playback.travel("Move")

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		jump()
		next_state = air_state
	if (event.is_action_pressed("dash") && can_dash):
		next_state = dash_state
	if (event.is_action_pressed("blink") && can_blink  && character.direction != Vector2.ZERO):
		next_state = blink_state
		
func state_process(delta):
	if !character.is_on_floor():
		playback.travel("jump_end")
		next_state = air_state
		
func jump():
	character.velocity.y = jump_velocity
