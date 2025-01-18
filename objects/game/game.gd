extends Node2D

var bullet_scene : PackedScene = preload("res://objects/projectiles/bullet.tscn")

func _on_player_bullet_shot(posit : Vector2, direct : Vector2) -> void:
	var bullet = bullet_scene.instantiate() as Area2D
	bullet.position = posit
	bullet.direction = direct
	$projectiles.add_child(bullet)

func _on_player_special_1_shot() -> void:
	print("SPECIAL 1")

func _on_player_special_2_shot() -> void:
	print("SPECIAL 2")
