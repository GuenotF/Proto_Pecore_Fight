extends "res://Scripts/Player.gd"

var weapon = preload("res://_Scenes/Weapons/Weapon_Shovel.tscn")

func _ready():
	
	pass

func _process(delta):
	aim(1, JOY_AXIS_2, JOY_AXIS_3)
	move("move_up2", "move_down2", "move_left2", "move_right2")
	
	if Input.is_action_just_pressed("shoot2") and can_fire:
		shoot(weapon.instance())
