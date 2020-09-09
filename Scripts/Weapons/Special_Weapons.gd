extends "res://Scripts/Weapons/Weapon.gd"

var is_on_floor = true


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


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
			player.weapon = self
			is_on_floor = false
