extends "res://Scripts/Player.gd"

var weapon = preload("res://_Scenes/Weapons/Weapon_Fork.tscn")

func _ready():
	
	pass

func _process(delta):
	aim(0, JOY_AXIS_2, JOY_AXIS_3)
	move("move_up", "move_down", "move_left", "move_right")
	
	if Input.is_action_just_pressed("shoot") and can_fire:
		shoot(weapon.instance())
