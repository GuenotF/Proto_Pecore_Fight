extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if $HUD.p1_winned or $HUD.p2_winned:
		if Input.is_action_pressed("start"):
			get_tree().reload_current_scene()