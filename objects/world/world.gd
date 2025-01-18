extends Node2D

signal selected_spawn(posit)

func player_random_spawn() -> Marker2D:
	# Chooses between 4 spawn locations and returns the selected one
	var player_markers : Array = $spawnPositions.get_children()
	var selected_marker : Marker2D = player_markers[randi() % player_markers.size()]
	return selected_marker

func _ready() -> void:
	selected_spawn.emit(player_random_spawn())
