extends KinematicBody2D

var bush_low = preload("res://Sprites/Proto_Bush-2.png")
onready var bush_sprite = get_node("Sprite")

export var life = 1


func _ready():
	#set_scale(Vector2(0.5, 0.5))
	pass

func hit():
	life = life - 1
	print(life)
	if life == 1:
		bush_sprite.set_texture(bush_low)
		
	if life <= 0:
		self.queue_free()

func _process(delta):
	if life <= 0:
		self.queue_free()
