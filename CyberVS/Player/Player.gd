extends KinematicBody2D

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 120
export var FRICTION = 500

const Bullet = preload("res://Bullet/Bullet.tscn")

enum {
	IDLE,
	WALK,
	RUN
}

var state = IDLE
var previous_state = IDLE
var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	detect_action(delta)
	apply_state()
	move()

func _input(event):
	if event.is_action_pressed("mouse_click"):
		shoot()

func shoot():
	var bullet = Bullet.instance()
	bullet.position = $Gun/Origin.global_position
	bullet.velocity = get_global_mouse_position() - bullet.position
	get_parent().add_child(bullet)
	
func detect_action(delta):
	previous_state = state
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		state = RUN
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		state = IDLE

func apply_state():
	if previous_state == state:
		return
	match state:
		IDLE:
			animationState.travel("Idle")
		WALK:
			animationState.travel("Walk")
		RUN:
			animationState.travel("Run")

func move():
	velocity = move_and_slide(velocity)
	#sprite.flip_h = velocity.x < 0
