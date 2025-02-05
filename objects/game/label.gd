extends Label

func text_remover() -> void:
	await get_tree().create_timer(1).timeout
	queue_free()	

func _ready() -> void:
	text_remover()
