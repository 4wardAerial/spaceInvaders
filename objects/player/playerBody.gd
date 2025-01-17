extends CharacterBody2D

const SPEED : float = 100.0
const MIN_VELOCITY : float = 10.0
const MAX_VELOCITY : float = 100.0
const ACCEL : float = 2.0
const DRAG : float = 1.0     

var can_attack : bool = true
var can_special_1 : bool = true
var can_special_2 : bool = true                                                                   

func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func movement_input(delta: float) -> void:
	# Makes the player look at the mouse and move to it in a straight line 
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("move"):		
		velocity += transform.x * Input.get_action_strength("move") * SPEED * ACCEL * delta
		
	else:
		# Reduces velocity until full stop
		if velocity.length() > MIN_VELOCITY:
			velocity -= velocity * DRAG * delta
		# Stops when size of the vector is smaller the min
		else:
			velocity = Vector2.ZERO

func specials_input() -> void:
	if Input.is_action_just_pressed("attack") and can_attack:
		can_attack = false
		$Timer.start(0.5)

		print("ATTACK")

	# Need to find a way to make multiple timers
	if Input.is_action_just_pressed("special1") and can_special_1:
		print("SPECIAL 1")
	
	if Input.is_action_just_pressed("special2") and can_special_2:
		print("SPECIAL 2")

func _process(delta: float) -> void:
	specials_input()

func _physics_process(delta: float) -> void:
	movement_input(delta)
	move_and_slide()
