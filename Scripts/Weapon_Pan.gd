extends Area2D

var bush = load("res://Scripts/Bush.gd").new()

export var speed = 1000
export var damage = 1
export var weapon_range = 0.5

var travel_time = Timer.new()

func _ready():
	set_scale(Vector2(0.2, 0.2))
	$AnimatedSprite.play("default")
	weapon_range()


func _physics_process(delta):
	position += transform.x * speed * delta
	
	

	# Clear node
	if position.y < -1000:
		queue_free()

func weapon_range():
	self.add_child(travel_time)
	
	travel_time.connect("timeout", self, "queue_free")
	travel_time.set_wait_time(weapon_range)
	travel_time.start()


func _on_Weapon_Pan_body_entered(body):
	if body.is_in_group("walls"):
		get_node("../" + body.get_name()).hit()
		speed = 0
		#$AnimatedSprite.play("destroy")
		#yield($AnimatedSprite, "animation_finished")
		queue_free()
		
	if body.is_in_group("Player1"):
		get_node("../Player1").hit()
		speed = 0
		#$AnimatedSprite.play("destroy")
		#yield($AnimatedSprite, "animation_finished")
		queue_free()
		
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
