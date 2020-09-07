extends KinematicBody2D

var weapon = preload("res://_Scenes/Weapons/Weapon_Shovel.tscn")

export var speed = 500
export var slow = 250
export var slow_duration = 0.5
export var bleed_duration = 0.5
export var life = 10
export var fire_rate = 0.3 #Pour test

var screen_size

var can_fire = true
var is_slowed = false

var movedir = Vector2(0,0)
var look_dir = Vector2()
var deadzone = 0.8


func _ready():
	$Blood.hide()
	screen_size = get_viewport_rect().size

func _physics_process(_delta):
	# Manage Movement
	movedir.x = -Input.get_action_strength("move_left2") + Input.get_action_strength("move_right2") #AXE1
	movedir.y = +Input.get_action_strength("move_down2") - Input.get_action_strength("move_up2") # AXE0
	
	var velocity = movedir * speed
	velocity = move_and_slide(velocity)
	
	aim()
	
	if Input.is_action_just_pressed("shoot2") and can_fire:
		shoot()
		
	if is_slowed:
		speed = slow
	else:
		speed = 500
	
	# Limit player to screen size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
func aim():
	# Manage Rotation
	look_dir.x = Input.get_joy_axis(1, JOY_AXIS_2)
	look_dir.y = Input.get_joy_axis(1, JOY_AXIS_3)
	if  look_dir.length() >= deadzone:
		rotation = look_dir.angle()

func shoot():
	var w = weapon.instance()
	owner.add_child(w)
	w.transform = $Shoot_Start.global_transform
	
	# Mécanique Mundo Couperet
	# life = life - 1
	# get_node("../HUD").update_Life_p2(life)
	
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true

	
func hit():
	life = life - 1
	
	slowed()
	bleeds()
	
	#print("Player " + life)
	if !get_node("../HUD").game_over:
		get_node("../HUD").update_Life_p2(life)
		if life <= 0:
			self.queue_free()

func slowed():
	is_slowed = true
	yield(get_tree().create_timer(slow_duration), "timeout")
	is_slowed = false

func bleeds():
	$Blood.show()
	yield(get_tree().create_timer(bleed_duration), "timeout")
	$Blood.hide()

