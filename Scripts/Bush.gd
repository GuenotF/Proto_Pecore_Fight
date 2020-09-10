extends KinematicBody2D

var bush_low = preload("res://Sprites/Walls/Proto_Bush-2.png")
onready var bush_sprite = get_node("Sprite")

export var life = 1


func _ready():
	#set_scale(Vector2(0.5, 0.5))
	pass

func hit(dmg):
	$Hit_Sound.play()
	life = life - dmg
	print(life)
	if life == 1:
		bush_sprite.set_texture(bush_low)
		
	if life <= 0:
		$Hit_Sound.play()
		yield($Hit_Sound, "finished")
		self.queue_free()

func _process(delta):
	pass
