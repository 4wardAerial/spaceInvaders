extends Area2D

const SPEED : float = 500.0

var direction : Vector2

func _process(delta: float) -> void:
	position += direction * SPEED * delta
