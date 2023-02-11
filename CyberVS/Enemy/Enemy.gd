extends KinematicBody2D

export var ACCELERATION = 200
export var MAX_SPEED = 30
export var FRICTION = 200

onready var sprite = $Sprite
onready var hurtbox = $Hurtbox
onready var health = 2

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

func _ready():
	var mat = sprite.get_material().duplicate(true)
	sprite.set_material(mat)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	var player = get_parent().get_node("Player")
	if player != null:
		accelerate_towards_point(player.global_position, delta)

	velocity = move_and_slide(velocity)

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x > 0

func _on_Hurtbox_area_entered(area):
	health -= area.damage
	#knockback = (self.position - area.get_parent().position)
	#hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.2)
	#TODO _on_Stats_no_health
	if health <= 0:
		queue_free()

#func _on_Stats_no_health():
	#queue_free()
	#var enemyDeathEffect = EnemyDeathEffect.instance()
	#get_parent().add_child(enemyDeathEffect)
	#enemyDeathEffect.global_position = global_position
