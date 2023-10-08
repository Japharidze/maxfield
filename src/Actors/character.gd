extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var falling : bool = false
var direction : Vector2 = Vector2.ZERO


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0 and not falling:
			animated_sprite.play("falling")
			falling = true
	if is_on_floor() and falling:
		falling = false

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	update_animation()
	update_facing()

func update_animation():
	if is_on_floor():
		if direction.x != 0:
			animated_sprite.play("moving")
		else:
			animated_sprite.play("idle")
	else:
		pass

func update_facing():
	if direction.x > 0:
		animated_sprite.flip_h = true
	elif direction.x < 0:
		animated_sprite.flip_h = false
	
func jump():
	velocity.y = JUMP_VELOCITY
	animated_sprite.play("jumping")


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "jumping":
		animated_sprite.play("falling")

