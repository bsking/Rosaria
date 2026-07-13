class_name NPCStateMachine extends Node

var states: Array[NPCState]
var previous_state: NPCState
var current_state: NPCState

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED 

func _process(_delta):
	ChangeState(current_state.process(_delta))
	
func _physics_process(_delta):
	ChangeState(current_state.physics(_delta)) 
	
func Initialize( _npc: NPC) -> void:
	states = []
	
	for c in get_children():
		if c is NPCState:
			states.append(c)
			
	for state in states:
		state.npc = _npc
		state.state_machine = self
		state.initialize()
		
	if states.size() > 0:
		ChangeState(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
		
func ChangeState( new_state : NPCState) -> void:
	if new_state == null || new_state == current_state:
		return 
	
	if current_state:
		current_state.exit()
		
	previous_state = current_state
	current_state = new_state
	
	current_state.enter()
