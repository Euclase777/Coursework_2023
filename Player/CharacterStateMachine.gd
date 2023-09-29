extends Node

class_name CharacterStateMachine

@export var current_state : State
@export var character : CharacterBody2D

var states : Array[State]

func _ready():
	for child in get_children():
		if(child is State):
			states.append(child)
			
			child.character = character
			
			
		else:
			push_warning("Child " + child.name + " is not s State for CharacterStateMachine")

func check_move():
	return current_state.can_move
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
