extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var v_cap = 2000
@export var jump_force = 700
 
func _physics_process(delta):
	#Vertical gravity
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > v_cap:
			velocity.y = v_cap
	
	#jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
	
	#Horizontal movement
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x = speed * horizontal_direction
	move_and_slide()
