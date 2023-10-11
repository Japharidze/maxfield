extends State

class_name GroundState

const SPEED = 300.0

@export var jump_velocity = -400.0
@export var air_state : State

var direction : Vector2 = Vector2.ZERO

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		character.velocity.y = jump_velocity
		playback.travel("jumping")
		next_state = air_state

	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x:
		character.velocity.x = direction.x * SPEED
	else:
		character.velocity.x = move_toward(character.velocity.x, 0, SPEED)
