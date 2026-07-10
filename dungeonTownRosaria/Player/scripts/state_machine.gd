class_name StateMachine extends Node

var states: Array[State]
var pre_state: State
var current_state: State

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	pass
	
func _process(delta):
	ChangeState(current_state.Process(delta))
	
func _physics_process(delta):
	ChangeState(current_state.Physics(delta)) 
	
func _unhandled_input(event: InputEvent) -> void:
	ChangeState(current_state.HandleInput(event))
	
func Initialize( _player: Player) -> void:
	states = []
	
	for c in get_children():
		if c is State:
			states.append(c)
	
	if states.size() == 0:
		return
	
	states[0].player = _player
	states[0].state_machine = self
		
	for state in states:
		state.initialize()
		
	ChangeState(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT
		
	
func ChangeState( new_state : State) -> void:
	if new_state == null || new_state == current_state:
		return 
	
	if current_state:
		current_state.Exit()
		
	pre_state = current_state
	current_state = new_state
	
	current_state.Enter()
