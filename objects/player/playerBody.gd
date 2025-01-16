extends CharacterBody2D

const SPEED : float = 300.0

func get_input():
	look_at(get_global_mouse_position())
	velocity = transform.x * Input.get_action_strength("move") * SPEED
	
func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
