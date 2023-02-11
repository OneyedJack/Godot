extends Node2D

const Enemy = preload("res://Enemy/Enemy.tscn")

onready var player = $Player
onready var enemyTimer = $EnemyTimer
onready var delay = 0.5

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	enemyTimer.start(delay)

#onready var tileMap = $TileMap

#func _ready():
	#for x in 100:
	#	for y in 100:
	#		#tileMap.set_cell(x - 50, y, 0, false, false, false, Vector2(rand_range(0, 5), rand_range(0, 5)))
	#		tileMap.set_cell(x - 50, y - 50, 0, false, false, false, Vector2(1, 0))


func _on_EnemyTimer_timeout():
	var enemy = Enemy.instance()
	var coor = rng.randf_range(0, 2 * PI)
	enemy.global_position = player.global_position + Vector2(cos(coor) * 200, sin(coor) * 200)
	add_child(enemy)
	
	#delay -= 0.01
	enemyTimer.start(delay)
