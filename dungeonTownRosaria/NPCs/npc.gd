class_name NPC extends CharacterBody2D

signal direction_changed (new_direction : Vector2)

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 3
@export var side_direction: int = 0
@export var npc_type = 0

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var player = Player
var invulnerable: bool = false
var _timer:float = -1.0

@onready var npc_state_machine: Node = $NPCStateMachine
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	npc_state_machine.Initialize(self)
	player = GlobalPlayerManager.player
	pass
	
func _physics_process(_delta: float) -> void:
	if is_on_wall() and _timer < 0.0 and npc_type == 0:
		_timer = 1.0
		npc_state_machine.ChangeState(npc_state_machine.states[0])
	
	if _timer > 0.0:
		_timer = _timer - _delta
	move_and_slide()
	
func Set_Direction(_new_direction: Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false
		
	var direction_id : int = int(round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction = DIR_4[direction_id]
		
	if new_direction == cardinal_direction:
		return false
	
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	if side_direction == 0:
		sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	else:
		sprite.scale.x = -1 if cardinal_direction == Vector2.RIGHT else 1
	
	return true
	
func UpdateAnimation(state) -> void:
	animation_player.play(state + "_" + AnimDirection())
	pass

func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"
	else:
		return "side"
