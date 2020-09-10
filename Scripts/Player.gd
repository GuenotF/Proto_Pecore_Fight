extends KinematicBody2D

var blood = Sprite.new()
var grabbed_weapon = Sprite.new()

export var speed = 500
export var slow = 250
export var slow_duration = 0.5
export var bleed_duration = 0.5
export var life = 10
export var fire_rate = 0.3

var screen_size

var can_fire = true
var have_spe = false
var is_slowed = false

var movedir = Vector2(0,0)
var look_dir = Vector2()
var deadzone = 0.8


func _ready():
	$AnimatedSprite.play("default")
	grabbed_weapon.position = $Spe_Shoot_Start.position
	grabbed_weapon.position.x =- 60
	$AnimatedSprite.add_child(grabbed_weapon)
	$Blood.hide()
	screen_size = get_viewport_rect().size

func _physics_process(_delta):
	#addSprite()
		
	var velocity = movedir * speed
	velocity = move_and_slide(velocity)

	if is_slowed:
		speed = slow
	else:
		speed = 500
	
	# Limit player to screen size
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func move(up, down, left, right):
		# Manage Movement
	movedir.x = -Input.get_action_strength(left) + Input.get_action_strength(right)
	movedir.y = +Input.get_action_strength(down) - Input.get_action_strength(up)


func aim(device, axis_x, axis_y):
	# Manage Rotation
	look_dir.x = Input.get_joy_axis(device, axis_x)
	look_dir.y = Input.get_joy_axis(device, axis_y)
	
	if  look_dir.length() >= deadzone:
		rotation = look_dir.angle()

func shoot(norm_weapon):
	var w = norm_weapon
	w.player = self
	w.set_scale(Vector2(0.5, 0.5))
	owner.add_child(w)
	w.transform = $Shoot_Start.global_transform
	
	#life = life - 1
	
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true
	

func spe_shoot(spe_weapon):
	var s_w = spe_weapon
	s_w.player = self
	s_w.set_scale(Vector2(0.5,0.5))
	owner.add_child(s_w)
	s_w.transform = $Spe_Shoot_Start.global_transform
	have_spe = false

func hit(dmg):
	life = life - dmg
	
	slowed()
	bleeds()
	$hit_sound.play()
	
	if life <= 0:
		$death_sound.play()
		#$AnimatedSprite.play("die")

	#print("Player " + life)
	

func slowed():
	is_slowed = true
	yield(get_tree().create_timer(slow_duration), "timeout")
	is_slowed = false

func bleeds():
	$Blood.show()
	yield(get_tree().create_timer(bleed_duration), "timeout")
	$Blood.hide()
