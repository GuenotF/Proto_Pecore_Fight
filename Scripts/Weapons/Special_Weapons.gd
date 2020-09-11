extends "res://Scripts/Weapons/Weapon.gd"

var s_w = preload("res://Sprites/Weapons/Proto_Spike.png")
var is_on_floor = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.get_name())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Special_Weapons_body_entered(body):
	if is_on_floor:
		if body.is_in_group("players"):
			player = body
			player.s_weapon = load("res://_Scenes/Weapons/Special_Weapons/" + self.get_name() + ".tscn")
			player.have_spe = true
			player.grabbed_weapon.set_texture($Sprite.texture)
			queue_free()
	else:
		if body.is_in_group("walls"):
			get_node("../" + body.get_name()).hit(damage)
			speed = 0
			queue_free()
		if body.is_in_group("shootable"):
			if body.get_name() != player.get_name():
				get_node("../" + body.get_name()).hit(damage)
				speed = 0
				queue_free()
