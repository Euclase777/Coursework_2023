extends State

class_name BlinkState

@export var air_state : State
@export var ground_state : State

func on_enter():
	blink()
	if character.is_on_floor():
		next_state = ground_state
	else:
		next_state = air_state
	
func blink():
	character.position.y += 100 * character.direction.y
	character.position.x += 100 * character.direction.x
	character.velocity.y = 0
	character.velocity.x = 0
