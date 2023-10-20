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

@onready var wallcheck : RayCast2D = $"../../WallJumpCheck"

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
		
func _physics_process(delta):
	# Add the gravity.
	character.velocity.y += gravity * delta
	

func state_process(delta):
	if character.is_on_floor():
		playback.travel("Move")
		air_dashes = 2
		next_state = ground_state
	elif wallcheck.is_colliding():
		playback.travel("wall_slide")
	else:
		playback.travel("jump_end")

func double_jump():
	if wallcheck.is_colliding():
		character.velocity.y = wall_jump_velocity * 1.5
		if character.sprite.flip_h:
			character.velocity.x = character.speed * 10
		else: 
			character.velocity.x = character.speed * -10
		character.sprite.flip_h = not character.sprite.flip_h
		wallcheck.target_position = -wallcheck.target_position
	elif double_jumps > 0:
		character.velocity.y = double_jump_velocity 
		double_jumps -= 1

func on_exit():
	if next_state == ground_state:
		double_jumps = 2
