extends CharacterBody2D

const GRAVITY = 1000
const SPEED = 1500

enum State { Idle, Walk }
var current_state : State
var direction : Vector2 = Vector2.LEFT


func _ready():
	current_state = State.Idle
	
	
func _physics_process(delta : float):
	enemy_gravity(delta)
	enemy_idle(delta)
	enemy_walk(delta)
	
	move_and_slide()
	
	
func enemy_gravity(delta : float):
	velocity.y += GRAVITY * delta


func enemy_idle(delta : float):
	velocity.x = move_toward(velocity.x, 0, SPEED * delta)
	current_state = State.Idle

func enemy_walk(delta : float):
	velocity.x = direction.x * SPEED * delta
	current_state = State.Walk
