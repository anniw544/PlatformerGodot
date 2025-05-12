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

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _physics_process(delta):
	#Vertical gravity
	if !phy_disable == 1:
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
	
	#jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = -jump_force
			
	#Dash
	if Input.is_action_just_pressed("dash"):
		if air_dash > 0:
			var Dhorizontal_direction = Input.get_axis("move_left", "move_right")
			var Dvertical_direction = Input.get_axis("move_up", "move_down")
			velocity.x = Dhorizontal_direction * dash_str
			velocity.y = Dvertical_direction * dash_str
			air_dash -= 1
			phy_disable = 1
			wait(2)
			phy_disable = 0
	
	#Horizontal movement
	if !phy_disable == 1:
		var horizontal_direction = Input.get_axis("move_left", "move_right")
		velocity.x = speed * horizontal_direction
		move_and_slide()
