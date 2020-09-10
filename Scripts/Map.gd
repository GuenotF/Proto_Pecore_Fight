extends Node2D

var weapon = preload("res://_Scenes/Weapons/Special_Weapons/Spe_Spike.tscn")

var blood_1 = preload("res://Sprites/FX/Blood/Blood1.png")
var blood_2 = preload("res://Sprites/FX/Blood/Blood2.png")
var blood_3 = preload("res://Sprites/FX/Blood/Blood3.png")

var blood_sprite = Sprite.new()
var blood = [blood_1, blood_2, blood_3]


# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_weapon($Spawn_Weapon)
	pass # Replace with function body.


func _process(delta):
	#spawn_blood()
	if $HUD.game_over:
		if Input.is_action_pressed("start"):
			get_tree().reload_current_scene()

func spawn_weapon(spawn):
	var w = weapon.instance()
	w.position = spawn.position
	w.speed = 0
	w.rotation = rand_range(0.1, 10)
	w.set_scale(Vector2(0.6,0.6))
	#w.set_global_scale(Vector2(3,3))
	w.weapon_range = 1000
	add_child(w)
	
func spawn_blood():
	if $Player1.is_slowed:
		blood_sprite.texture = load("res://Sprites/FX/Blood/Blood1.png")
		blood_sprite.position = $Player1.position
		yield(get_tree().create_timer($Player1.bleed_duration), "timeout")
		self.add_child(blood_sprite)

	if $Player2.is_slowed:
		blood_sprite.texture = load("res://Sprites/FX/Blood/Blood2.png")
		blood_sprite.position = $Player2.position
		yield(get_tree().create_timer($Player2.bleed_duration), "timeout")
		self.add_child(blood_sprite)
	
	
