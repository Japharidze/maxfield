extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State

var states : Array[State]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			child.character = character
			states.append(child)
		else:
			push_warning("Not state" + child.name)
	print(states)

func _physics_process(_delta):
	if current_state.next_state:
		var new_state = current_state.next_state
		current_state = new_state
		# current_state.next_state = null

func _input(event):
	current_state.state_input(event)
