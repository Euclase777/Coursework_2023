extends State

class_name DashState

@export var air_state : State
@export var ground_state : State
@export var dash_speed : float = 1200.0

func on_enter():
	playback.travel("dash")

func dash():
	character.velocity.y = -10
	if character.sprite.flip_h:
		character.velocity.x = -dash_speed
	else:
		character.velocity.x = dash_speed

func afterdash():
	next_state = air_state
