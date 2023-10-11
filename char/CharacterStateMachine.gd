extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State
@export var animation_tree : AnimationTree

var states : Array[State]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			child.character = character
			child.playback = animation_tree["parameters/playback"]
		else:
			push_warning("Child " + child.name + " is not a State for CharacterStateMachine")

func check_can_move():
	return current_state.can_move


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(current_state.next_state != null):
		switch_states(current_state.next_state)
		
	current_state.state_process(delta)
		
func switch_states(new_state : State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	
	current_state = new_state
	
	current_state.on_enter()

func _input(event : InputEvent):
	current_state.state_input(event)
