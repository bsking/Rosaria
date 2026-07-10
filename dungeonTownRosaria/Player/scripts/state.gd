class_name State extends Node

## store reference to player
static var player: Player
static var state_machine: StateMachine

func _ready():
	pass
	
func initialize() -> void:
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta: float) -> State:
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	

	
