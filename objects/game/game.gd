extends Node2D

var bullet_scene : PackedScene = preload("res://objects/projectiles/bullet.tscn")

func _on_world_selected_spawn(posit : Marker2D) -> void:
	$player.position = posit.position

func _on_player_bullet_shot(posit : Vector2, direct : Vector2) -> void:
	# Creates and instance of the bullet
	var bullet : Area2D = bullet_scene.instantiate() as Area2D
	bullet.position = posit
	bullet.direction = direct
	# Drawns said bullet
	$projectiles.add_child(bullet)

func _on_player_special_1_shot() -> void:
	print("SPECIAL 1")

func _on_player_special_2_shot() -> void:
	print("SPECIAL 2")

func _on_player_fell_off() -> void:
	$player.queue_free()
