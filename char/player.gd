extends CharacterBody2D


@export var speed : float = 60.0
@export var tilemap : TileMap

@onready var sprite : Sprite2D = $Sprite
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var raycast : RayCast2D = $WallJumpCheck

# Get the gravity from the project settings to be synced with RigidBody nodes.
var direction : Vector2 = Vector2.ZERO
var block : Vector2i
var chunk : Vector2i
func _ready():
	animation_tree.active = true;

func _process(delta):
	block = (position / Vector2(8,8)).floor()
	chunk = (position / Vector2(320,320)).floor()

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction && state_machine.check_can_move():
		velocity.x = move_toward(velocity.x, 10 * speed * direction.x, speed)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, speed)
		else:
			velocity.x = move_toward(velocity.x, 1, speed/4)

	move_and_slide()
	update_animation()
	update_facing_direction()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
		raycast.target_position=Vector2i(32,0)
	elif direction.x < 0:
		sprite.flip_h = true 
		raycast.target_position=Vector2i(-32,0)
