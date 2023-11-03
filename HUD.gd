extends CanvasLayer

@export var character : CharacterBody2D
@onready var jumpbar : TextureProgressBar = $JumpBar

# Called when the node enters the scene tree for the first time.
func _ready():
	jumpbar.max_value = character.max_double_jumps
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	jumpbar.value = character.double_jumps
	pass
