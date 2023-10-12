extends State

class_name AirState

@export var ground_state : State
@export var dash_state : State
@export var blink_state : State
@export var double_jump_velocity : float = -350.0
@export var wall_jump_velocity : float = -350.0
@export var dash_speed : float = 1200.0
@export var air_dashes : int = 2
@export var double_jumps : int = 2

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func on_enter():
	playback.travel("jump")

func state_input(event : InputEvent):
	if (event.is_action_pressed("jump")):
		double_jump()
	if (event.is_action_pressed("dash") && air_dashes > 0):
		next_state = dash_state
		air_dashes -=1
	if (event.is_action_pressed("blink") && air_dashes > 0  && character.direction != Vector2.ZERO):
		next_state = blink_state
		air_dashes -=1
	if (event.is_action_pressed("move_down")):
		character.velocity.y = 1000
		character.velocity.x = 0
	if (event.is_action_pressed("hold")):
		gravity = 0
		character.velocity.y = 10
	else:
		gravity = 735
		
func _physics_process(delta):
		# Add the gravity.
		if character.is_on_wall() && character.velocity.y > 0:
			character.velocity.y += gravity * delta * 0.5
		else:
			character.velocity.y += gravity * delta

func state_process(delta):
	if character.is_on_floor():
		playback.travel("Move")
		air_dashes = 2
		next_state = ground_state
	elif character.is_on_wall():
		playback.travel("wall_slide")
	else:
		playback.travel("jump_end")

func double_jump():
	if character.is_on_wall():
		character.velocity.y = wall_jump_velocity * 1.5
		character.velocity.x = -character.direction.x * character.speed * 10
	elif double_jumps > 0:
		character.velocity.y = double_jump_velocity 
		double_jumps -= 1

func on_exit():
	if next_state == ground_state:
		double_jumps = 2
