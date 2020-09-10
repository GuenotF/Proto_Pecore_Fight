extends KinematicBody2D

var barrier_0 = preload("res://Sprites/Walls/Proto_Barrier/barrier_0.png")
var barrier_1 = preload("res://Sprites/Walls/Proto_Barrier/barrier_1.png")
var barrier_2 = preload("res://Sprites/Walls/Proto_Barrier/barrier_2.png")
var barrier_3 = preload("res://Sprites/Walls/Proto_Barrier/barrier_3.png")
var barrier_4 = preload("res://Sprites/Walls/Proto_Barrier/barrier_4.png")
var barrier_5 = preload("res://Sprites/Walls/Proto_Barrier/barrier_5.png")

var sprites = [barrier_0, barrier_1, barrier_2, barrier_3, barrier_4, barrier_5]

onready var barrier_sprite = get_node("Sprite")

export var life = 5


func _ready():
	#set_scale(Vector2(0.5, 0.5))
	pass

func hit(dmg):
	$Hit_Sound.play()
	life = life - dmg
	barrier_sprite.set_texture(sprites[life])
	print(life)
	
		
	if life <= 0:
		$Hit_Sound.play()
		yield($Hit_Sound, "finished")
		self.queue_free()

func _process(delta):
	pass
