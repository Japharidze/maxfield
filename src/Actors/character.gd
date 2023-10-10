extends CharacterBody2D


const SPEED = 300.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
#@onready var state_machine : CharacterStateMachine = $CharacterStateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling : bool = false
var direction : Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0 and not falling:
			falling = true
	if is_on_floor() and falling:
		falling = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction.x: # and state_machine.current_state.can_move:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	update_animation()
	update_facing()

func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)

func update_facing():
	if direction.x > 0:
		sprite.flip_h = true
	elif direction.x < 0:
		sprite.flip_h = false
