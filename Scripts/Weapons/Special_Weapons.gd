extends "res://Scripts/Weapons/Weapon.gd"

var s_w = preload("res://Sprites/Weapons/Proto_Spike.png")
var is_on_floor = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Special_Weapons_body_entered(body):
	if is_on_floor:
		if body.is_in_group("players"):
			player = body
			print(self.get_path())
			#player.s_weapon = get_node(self.get_path())
			player.have_spe = true
			player.grabbed_weapon.set_texture(s_w)
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
