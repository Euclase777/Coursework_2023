extends State

class_name DashState

@export var air_state : State
@export var ground_state : State
@export var dash_speed : float = 1200.0

func on_enter():
	dash()
	if character.is_on_floor():
		next_state = ground_state
	else:
		next_state = air_state

func dash():
	character.velocity.y = -10
	if character.sprite.flip_h:
		character.velocity.x = character.direction.x * dash_speed
	else:
		character.velocity.x = character.direction.x * dash_speed
