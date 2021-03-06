extends Area2D

var player

export var speed = 1000
export var damage = 1
export var weapon_range = 0.5



var travel_time = Timer.new()

func _ready():
	#set_scale(Vector2(0.2, 0.2))
	$AnimatedSprite.play("default")
	weapon_range(weapon_range)


func _physics_process(delta):
	position += transform.x * speed * delta

func weapon_range(w_range):
	self.add_child(travel_time)
	travel_time.connect("timeout", self, "queue_free")
	travel_time.set_wait_time(w_range)
	travel_time.start()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Weapon_body_entered(body):
	print('Fork: '+ player.get_name())
	if body.is_in_group("walls"):
		get_node("../" + body.get_name()).hit()
		speed = 0
		queue_free()
	#if is_on_floor:
	#	if body.is_in_group("players"):
	#		player = body
	#		player.weapon = self
	#		is_on_floor = false
	if body.is_in_group("shootable"):
		#player.weapon = self
		#is_on_floor = false
		if body.get_name() != player.get_name():
			get_node("../" + body.get_name()).hit()
			speed = 0
			queue_free()
	else:
		pass
