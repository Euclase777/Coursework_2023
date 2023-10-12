extends State

class_name BlinkState

@export var air_state : State
@export var ground_state : State

var can_blink : bool

func on_enter():
	playback.travel("blink")
	if character.is_on_floor():
		next_state = ground_state
	else:
		next_state = air_state

func blink():
	if can_blink:
		character.position.y += 100 * character.direction.y
		character.position.x += 100 * character.direction.x
		character.velocity.y = 0
		character.velocity.x = 0

func _on_area_2d_body_entered(body):
	can_blink = false

func _on_area_2d_body_exited(body):
	can_blink = true
