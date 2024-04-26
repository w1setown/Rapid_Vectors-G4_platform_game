extends CharacterBody2D
@onready var animated_sprite_2d = $AnimatedSprite2D

var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 350
const JUMP = -300
const JUMP_HORIZONTAL = 100
enum State {
		idle, 
		run,
		jump,
		falling
}
var current_state: State




func _ready():
	current_state = State.idle


func _physics_process(delta : float): 
	player_falling(delta)
	player_idle (delta)
	player_run (delta)
	player_jump (delta)
	
	move_and_slide()
	
	player_animations()
	
	print("State: ", State.keys()[current_state])    
	#print("State: ", str(current_state)) | Here we are using a string, which is servicable to a certain extent, 
	#the only issue is, the out will only be define as intergers ie. (State: 0 | State: 1)

func player_falling(delta : float):
	if !is_on_floor():
		velocity.y += GRAVITY * delta

func player_idle(delta : float):
	if is_on_floor():
		current_state = State.idle


func player_run (delta : float):
	if !is_on_floor():
		return
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction !=0:
		current_state = State.run
		animated_sprite_2d.flip_h = false if direction > 0 else true # ternary statement/conditional operator

func player_jump (delta : float):
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP
		current_state = State.jump
		
		
	if !is_on_floor() and State.run and current_state == State.jump:
		var direction = Input.get_axis("move_left", "move_right")
		velocity.x += direction * JUMP_HORIZONTAL * delta
		
	
		
func player_animations():
	if current_state == State.idle:
		animated_sprite_2d.play("idle")
	elif current_state == State.run:
		animated_sprite_2d.play("run")
	elif current_state == State.jump:
		animated_sprite_2d.play("jump")
