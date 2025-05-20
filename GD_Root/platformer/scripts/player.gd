extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var drag = 30
@export var v_cap = 2000
@export var jump_force = 700
@export var dash_str = 1000
@export var max_dash_ammount = 1
var air_dash = 0
var phy_disable = 0
var freeze_frame = 0
var grav_disable = 0


func _physics_process(delta):
	#Vertical gravity
	if grav_disable == 0:	
		if !is_on_floor():
			velocity.y += gravity
			if velocity.y > v_cap:
				velocity.y = v_cap
				
				
	#Horizontal drag
	if velocity.x > 0:
		velocity.x -= drag
	elif velocity.x <0:
		velocity.x += drag
	
	
	#Floor reset
	if is_on_floor():
		air_dash = max_dash_ammount
		phy_disable = 0
		
		
	#jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
			
			
	#Dash
	if Input.is_action_just_pressed("dash"):
		if air_dash > 0:
			var Dhorizontal_direction = Input.get_axis("move_left", "move_right")
			var Dvertical_direction = Input.get_axis("move_up", "move_down")
			air_dash -= 1
			phy_disable = 1
			grav_disable = 1
			velocity.x = Dhorizontal_direction * dash_str
			velocity.y = Dvertical_direction * dash_str
			await get_tree().create_timer(.1).timeout
			grav_disable = 0
			
		
	#Horizontal movement
	if phy_disable == 0:
		var horizontal_direction = Input.get_axis("move_left", "move_right")
		velocity.x = speed * horizontal_direction
	elif phy_disable == 1:
		var horizontal_direction = Input.get_axis("move_left", "move_right")
		velocity.x += speed * horizontal_direction
		
	if freeze_frame == 0:
		move_and_slide()
