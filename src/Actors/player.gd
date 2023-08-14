extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var double_jump_velocity : float = -400.0 

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var character_sprite : Sprite2D = $Sprite2D
@onready var anim_tree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")

func _ready():
	anim_state.travel("moving")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		pass
		#has_double_jumped = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		#elif not has_double_jumped:
		#	velocity.y = double_jump_velocity
		#	has_double_jumped = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	print(direction)
	if direction:
		character_sprite.flip_h = bool(direction+1)
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
