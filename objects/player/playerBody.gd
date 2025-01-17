extends CharacterBody2D

const SPEED : float = 100.0
const ROTATION_SPEED : float = 1.0
const MIN_VELOCITY : float = 10.0
const MAX_VELOCITY : float = 100.0
const MAX_CANNON_ANGLE : int = 60
const ACCEL : float = 1.0
const DRAG : float = 2.0     

var rotation_direction : float = 0
var can_attack : bool = true
var can_special_1 : bool = true
var can_special_2 : bool = true                                                                   

func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func _on_special_1_cooldown_timeout() -> void:
	can_special_1 = true

func _on_special_2_cooldown_timeout() -> void:
	can_special_2 = true
	
func cannon_rotation() -> void:
	# Makes the cannon part of the sprite follow the mouse
	$playerTopSprite.look_at(get_global_mouse_position())
	# Stops cannon rotation at certain angle
	$playerTopSprite.rotation_degrees = clamp($playerTopSprite.rotation_degrees, -MAX_CANNON_ANGLE, MAX_CANNON_ANGLE)

func movement_input(delta: float) -> void:
	# Bottom part of the sprite rotates via input
	rotation_direction = Input.get_axis("left", "right")
	
	if Input.is_action_pressed("down") or Input.is_action_pressed("up"):
		# '+=' gives acceleration, but velocity is limited by 'limit_length'
		velocity += transform.x * Input.get_axis("down", "up") * SPEED * ACCEL * delta
		velocity = velocity.limit_length(MAX_VELOCITY)
		
	else:
		# Reduces velocity until full stop
		if velocity.length() > MIN_VELOCITY:
			velocity -= velocity * DRAG * delta
		# Stops when size of the vector is smaller the min
		else:
			velocity = Vector2.ZERO

func specials_input() -> void:
	if Input.is_action_just_pressed("attack") and can_attack:
		print("ATTACK")
		can_attack = false
		$playerTimers/attackCooldown.start(0.5)

	if Input.is_action_just_pressed("special1") and can_special_1:
		print("SPECIAL 1")
		can_special_1 = false
		$playerTimers/special1Cooldown.start(2.0)

	if Input.is_action_just_pressed("special2") and can_special_2:
		print("SPECIAL 2")
		can_special_2 = false
		$playerTimers/special2Cooldown.start(5.0)


func _process(delta: float) -> void:
	cannon_rotation()
	specials_input()

func _physics_process(delta: float) -> void:
	movement_input(delta)
	rotation += rotation_direction * ROTATION_SPEED * delta
	move_and_slide()
