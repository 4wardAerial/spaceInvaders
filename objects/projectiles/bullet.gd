extends Area2D

const SPEED : float = 600.0

var direction : Vector2

func _process(delta: float) -> void:
	position += direction * SPEED * delta
