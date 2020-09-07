extends KinematicBody2D

var weapon = preload("res://_Scenes/Weapons/Weapon_Fork.tscn")

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
	movedir.x = -Input.get_action_strength("move_left") + Input.get_action_strength("move_right")
	movedir.y = +Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	var velocity = movedir * speed
	velocity = move_and_slide(velocity)
	
	aim()
	
	if Input.is_action_just_pressed("shoot") and can_fire:
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
	#if  look_dir.length() >= deadzone:
	look_dir.x = Input.get_joy_axis(0, JOY_AXIS_2)
	look_dir.y = Input.get_joy_axis(0, JOY_AXIS_3)
	rotation = look_dir.angle()
	#else:
	look_dir.x = 0
	look_dir.y = 0

func shoot():
	var w = weapon.instance()
	w.set_scale(Vector2(0.5, 0.5))
	owner.add_child(w)
	w.transform = $Shoot_Start.global_transform
	
	#life = life - 1
	
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
	
	
	
	
	
func hit():
	life = life - 1
	
	slow()
	bleeds()

	#print("Player " + life)
	get_node("../HUD").update_Life_p1(life)
	if life <= 0:
		self.queue_free()

func slow():
	is_slowed = true
	yield(get_tree().create_timer(slow_duration), "timeout")
	is_slowed = false

func bleeds():
	
	$Blood.show()
	yield(get_tree().create_timer(bleed_duration), "timeout")
	$Blood.hide()


