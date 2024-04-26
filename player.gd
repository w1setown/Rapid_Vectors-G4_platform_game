extends CharacterBody2D

func _ready():
	pass



func _physics_process(delta):
	player_falling(delta)
	
	move_and_slide()


func player_falling(delta):
	if !is_on_floor():
		velocity.y += 1000 + delta

