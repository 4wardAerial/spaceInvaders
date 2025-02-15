extends CharacterBody2D

signal bullet_shot(posit, direct)
signal special_1_shot
signal special_2_shot
signal fell_off

const SPEED : float = 200.0
const ROTATION_SPEED : float = 0.8
const MIN_VELOCITY : float = 10.0
const MAX_VELOCITY : float = 200.0
const MAX_CANNON_ANGLE : int = 75
const ACCEL : float = 1.0
const DRAG : float = 2.0     

var rotation_direction : float = 0
var can_control : bool = false
var can_attack : bool = true
var can_special_1 : bool = true
var can_special_2 : bool = true                                                                   

func _on_attack_cooldown_timeout() -> void:
	can_attack = true

func _on_special_1_cooldown_timeout() -> void:
	can_special_1 = true

func _on_special_2_cooldown_timeout() -> void:
	can_special_2 = true

func _on_camera_finished_zoom() -> void:
	can_control = true
	
func cannon_rotation() -> void:
	# Makes the cannon part of the sprite follow the mouse
	$playerTopSprite.look_at(get_global_mouse_position())

func movement_input(delta : float) -> void:
	# Bottom part of the sprite rotates via input
	rotation_direction = Input.get_axis("left", "right")
	rotation += rotation_direction * ROTATION_SPEED * delta
	
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
	var cannon_direction : Vector2 = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_just_pressed("attack") and can_attack:
		can_attack = false
		$playerTimers/attackCooldown.start(0.5)
		bullet_shot.emit($playerTopSprite/bulletMarker.global_position, cannon_direction)
		
	if Input.is_action_just_pressed("special1") and can_special_1:
		can_special_1 = false
		$playerTimers/special1Cooldown.start(2.0)
		special_1_shot.emit()
		
	if Input.is_action_just_pressed("special2") and can_special_2:
		can_special_2 = false
		$playerTimers/special2Cooldown.start(5.0)
		special_2_shot.emit()
		
func check_position() -> void:
	if position.x < 0 or position.x > 9600 or position.y < 0 or position.y > 5400:
		fell_off.emit()

func _process(delta : float) -> void:
	check_position()
	
	if can_control:
		specials_input()
		movement_input(delta)

func _physics_process(delta : float) -> void:
	cannon_rotation()
	move_and_slide()
