class_name State_Attack extends State

var attacking: bool = false

@export var attack_sound: AudioStream
@export_range(1, 20, 0.5) var decelerate_speed: float = 5
@onready var idle: State = $"../Idle"
@onready var walk: State = $"../Walk"

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var audio_stream: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"
@onready var attack_animation: AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AttackAnimationPlayer"

#@onready var hurt_box: HurtBox = %AttackHurtBox


func Enter() -> void:
	player.UpdateAnimation("attack")
	attack_animation.play("attack_" + player.AnimDirection())
	animation_player.animation_finished.connect(EndAttack)
	
	audio_stream.stream = attack_sound
	audio_stream.pitch_scale = randf_range(0.9, 1.1)
	audio_stream.play()
	
	attacking = true
	
	await get_tree().create_timer(0.075).timeout
	#if attacking:
		#hurt_box.monitoring = true
	pass
	
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	#hurt_box.monitoring = false
	pass
	
func Process(_delta: float) -> State:
	player.velocity -= player.velocity * decelerate_speed * _delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
func Physics(_delta: float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func EndAttack(_newAnimationName : String) -> void:
	attacking = false
	
