extends KinematicBody2D

onready var destroyTimer = $Timer
onready var particles = $Particles2D

var velocity = Vector2(1, 0)
var speed = 400

func _ready():
	destroyTimer.start(0.2)

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed)
	particles.process_material.set("direction", Vector3(velocity.x,  velocity.y, 0))

func _on_Hitbox_area_entered(area):
	queue_free()

func _on_Timer_timeout():
	queue_free()
