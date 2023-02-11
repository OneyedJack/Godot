extends Node2D

#const Bullet = preload("res://Bullet/Bullet.tscn")

onready var sprite = $Sprite

var mouse_position

func _process(delta):
	mouse_position = get_local_mouse_position()
	rotation += mouse_position.angle()

#func _input(event):
#	if event.is_action_pressed("click"):
#		shoot()

#func shoot():
#	var bullet = Bullet.instance()
#	add_child(bullet)
#	bullet.global_position = global_position
