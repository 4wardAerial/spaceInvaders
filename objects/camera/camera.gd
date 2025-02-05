extends Camera2D

@onready var player : Node2D = get_node("../player")
@onready var during_start : bool = true

signal finished_zoom

const START_LIMIT : int = 9999999

var zoom_lerp : float = 0.0
var position_lerp : float = 1.0

func _ready() -> void:
	# Puts camera on center of stage and zoomed out enough to see the entire board
	position = Vector2(4800, 2700)
	zoom = Vector2(0.1, 0.1)

func follow_player() -> void:
	if player != null:
		position = player.position

func _process(delta : float) -> void:
	if during_start:
		start_zoom(delta)
	else:
		follow_player()

func set_start_limit() -> void:
	limit_left = -START_LIMIT
	limit_top = -START_LIMIT
	limit_right = START_LIMIT
	limit_bottom = START_LIMIT

func set_final_limit() -> void:
	limit_left = -250
	limit_top = -250
	limit_right = 9850
	limit_bottom = 5650

func start_zoom(delta : float) -> void:
	set_start_limit()
	# Lerps first the position of the camera to the player's
	await get_tree().create_timer(1).timeout	
	position_lerp += delta
	position = position.lerp(player.position, position_lerp)
	# Lerps second the zoom of the camera, a bit stagger-y 
	await get_tree().create_timer(1).timeout
	zoom_lerp += delta * 1.5
	zoom = zoom.lerp(Vector2(0.75, 0.75), zoom_lerp)

	set_final_limit()
	during_start = false
	await get_tree().create_timer(0.5).timeout
	finished_zoom.emit()
