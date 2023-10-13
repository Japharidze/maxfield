extends Node

class_name State

@export var can_move : bool = true

var character : CharacterBody2D
var sprite : Sprite2D
var playback : AnimationNodeStateMachinePlayback
var next_state : State

func state_input(_event):
	pass

func state_process(_delta):
	pass

func on_enter():
	pass
