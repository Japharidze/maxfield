extends Node

class_name CharacterStateMachine

@export var character : CharacterBody2D
@export var current_state : State

var states : Array[State]

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
		else:
			push_warning("Not state" + child.name)
