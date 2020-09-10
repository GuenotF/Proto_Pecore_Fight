extends "res://Scripts/Player.gd"

var weapon = preload("res://_Scenes/Weapons/Weapon_Shovel.tscn")
var s_weapon #= preload("res://_Scenes/Weapons/Special_Weapons/Spe_Spike.tscn")

func _ready():
	pass

func _process(delta):
	aim(1, JOY_AXIS_2, JOY_AXIS_3)
	move("move_up2", "move_down2", "move_left2", "move_right2")
	
	if Input.is_action_just_pressed("shoot2") and can_fire:
		shoot(weapon.instance())
	
	if Input.is_action_just_pressed("shoot_spe") and have_spe:
		#print('Shoot '+ s_weapon.get_name())
		var sw = s_weapon.instance()
		sw.is_on_floor = false
		spe_shoot(sw)
		grabbed_weapon.set_texture(null)
		
	if !get_node("../HUD").game_over:
		get_node("../HUD").update_Life_p2(life)
		if life <= 0:
			get_node("../HUD").p1_wins.show()
			self.queue_free()
