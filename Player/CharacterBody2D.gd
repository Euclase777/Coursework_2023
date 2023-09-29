extends CharacterBody2D

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite = $Sprite2D
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var doublejump
var direction

func _ready():
	animation_tree.active = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# GRAVITY
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		doublejump = true
		
	direction = Input.get_vector("move_left", "move_right", "move_up","move_down")
	if direction.x && state_machine.check_move():
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# BLINK (WIP)
	if Input.is_action_just_pressed("dash"):
		if Input.is_action_pressed("move_left"):
			position.x = move_toward(position.x, position.x-100, SPEED)
		if Input.is_action_pressed("move_right"):
			position.x = move_toward(position.x, position.x+100, SPEED)
			
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or is_on_wall():
			velocity.y = JUMP_VELOCITY
		elif doublejump:
			doublejump = false
			velocity.y = JUMP_VELOCITY
			

	# STOMP
	if Input.is_action_pressed("move_down") and not(is_on_floor()) and not(Input.is_action_pressed("jump")):
		velocity.y += 100
		velocity.x = 0
		
	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	animation_tree.set("parameters/Run/blend_position", direction.x)


func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
