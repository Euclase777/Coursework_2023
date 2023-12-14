extends Area2D

@export var in_wall : bool = false
@export var character : CharacterBody2D
var direction : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	position = 120 * direction
	
