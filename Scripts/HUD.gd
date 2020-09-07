extends CanvasLayer

var hb_10 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_10.png")
var hb_09 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_09.png")
var hb_08 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_08.png")
var hb_07 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_07.png")
var hb_06 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_06.png")
var hb_05 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_05.png")
var hb_04 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_04.png")
var hb_03 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_03.png")
var hb_02 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_02.png")
var hb_01 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_01.png")
var hb_00 = preload("res://Sprites/HUD/Proto_Life_Points/health_bar_00.png")

var life = [hb_00, hb_01, hb_02, hb_03, hb_04, hb_05, hb_06, hb_07, hb_08, hb_09, hb_10]

onready var life_p1_sprite = get_node("LifeP1")
onready var life_p2_sprite = get_node("LifeP2")
onready var p1_wins = get_node("P1_Wins")
onready var p2_wins = get_node("P2_Wins")
onready var restart_btn = get_node("Control/Restart_Btn")

var p1_winned = false;
var p2_winned = false;
var game_over = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	p1_wins.hide()
	p2_wins.hide()
	restart_btn.hide()
	life_p1_sprite.set_texture(hb_10)
	life_p2_sprite.set_texture(hb_10)
	
	#$music.play()
	

func _process(delta):
	pass

func update_Life_p1(hp):
	$hurt1.play()
	life_p1_sprite.set_texture(life[hp])
	if hp == 0:
		game_over = true
		p2_winned = true
		$sound_P2_Wins.play()
		p2_wins.show()
		restart_btn.show()

func update_Life_p2(hp):
	$hurt2.play()
	life_p2_sprite.set_texture(life[hp])
	if hp == 0:
		game_over = true
		p1_winned = true
		$sound_P1_Wins.play()
		p1_wins.show()
		restart_btn.show()


func _on_Restart_Btn_pressed():
	get_tree().reload_current_scene()
