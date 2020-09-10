extends "res://Scripts/Player.gd"

var weapon = preload("res://_Scenes/Weapons/Weapon_Fork.tscn")
var s_weapon = preload("res://_Scenes/Weapons/Special_Weapons/Spe_Spike.tscn")

func _ready():
	
	pass

func _process(delta):
	aim(0, JOY_AXIS_2, JOY_AXIS_3)
	move("move_up", "move_down", "move_left", "move_right")
	
	if Input.is_action_just_pressed("shoot") and can_fire:
		shoot(weapon.instance())
		
	if Input.is_action_just_pressed("shoot_spe") and have_spe:
		#print('Shoot '+ s_weapon.get_name())
		spe_shoot(s_weapon.instance())

	if !get_node("../HUD").game_over:
		get_node("../HUD").update_Life_p1(life)
		
		if life <= 0:
			get_node("../HUD").p2_wins.show()
			self.queue_free()
