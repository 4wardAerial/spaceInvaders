extends Camera2D

@onready var player = get_node("../player")

func follow_player() -> void:
	if player != null:
		position = player.position

func _process(delta: float) -> void:
	follow_player()
