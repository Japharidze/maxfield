extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var animation_tree : AnimationTree
@export var current_state : State

var states : Array[State]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			child.character = character
			child.playback = animation_tree["parameters/playback"]
			states.append(child)
		else:
			push_warning("Not state" + child.name)

func _physics_process(delta):
	if current_state.next_state:
		var new_state = current_state.next_state
		current_state = new_state
		current_state.next_state = null
		current_state.on_enter()
	current_state.state_process(delta)
	
func _input(event):
	current_state.state_input(event)
