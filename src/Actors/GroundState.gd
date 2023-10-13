extends State

class_name GroundState

const SPEED = 300.0

@export var jump_velocity = -400.0
@export var air_state : State

var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO

func state_input(event: InputEvent):
	if event.is_action_pressed("ui_accept"):
		character.velocity.y = jump_velocity
		character.move_and_slide()
		playback.travel("jumping")
		next_state = air_state
		

func state_process(_delta):
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	character.velocity = velocity
	
	get_parent().animation_tree.set("parameters/Move/blend_position", direction.x)
	update_facing()

func update_facing():
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
