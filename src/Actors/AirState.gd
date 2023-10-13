extends State

class_name AirState

@export var ground_state : State

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling : bool = false


func state_process(delta):
	character.velocity.y += gravity * delta
	if character.velocity.y > 0 and not falling:
		falling = true
		playback.travel("falling")
	if character.is_on_floor():
		falling = false
		next_state = ground_state
