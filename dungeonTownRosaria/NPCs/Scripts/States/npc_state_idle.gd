class_name NPCStateIdle extends NPCState

@export var animation_name: String = "idle"
@export_category("AI")
@export var state_duration_minimum: float = 0.5
@export var state_duration_maximum: float = 1.5
@export var after_idle_state: NPCState

var _timer:float = 0.0

func initialize() -> void:
	pass
	
func enter() -> void:
	npc.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_minimum, state_duration_minimum)
	npc.UpdateAnimation(animation_name)
	pass
	
func exit() -> void:
	pass
	
func process(_delta: float) -> NPCState:
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
		
	return null
	
func physics(_delta: float) -> NPCState:
	return null
