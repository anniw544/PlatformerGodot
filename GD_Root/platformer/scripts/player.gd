extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var v_cap = 2000
@export var jump_force = 700
@export var max_extra_jump = 1
var air_jump = 0 

func _physics_process(delta):
	#Vertical gravity
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > v_cap:
			velocity.y = v_cap
	
	if is_on_floor():
		air_jump = max_extra_jump
	
	#jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
		if air_jump > 0 && !is_on_floor():
			velocity.y = -jump_force
			air_jump = air_jump - 1
	
	#Horizontal movement
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
