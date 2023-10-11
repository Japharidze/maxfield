extends Label

@export var state_machine : CharacterStateMachine
@export var anim_player : AnimationPlayer
@export var anim_tree : AnimationTree

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "State: " + state_machine.current_state.name \
		+ "\n Animation: " + anim_tree["parameters/playback"].get_current_node()
	#print(anim_tree['parameters/playback'].get_current_node())
