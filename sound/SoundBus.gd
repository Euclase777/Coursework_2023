extends Node

@onready var music = $Music
@onready var shoot_sound = $ShootSound
@onready var enemy_death_sound = $EnemyDeathSound
@onready var reload_sound = $ReloadSound

func _ready():
	#Events.play_die_sound.connect(_on_play_die_sound)
	pass

func _on_play_die_sound():
	enemy_death_sound.play()

func _on_play_shoot_sound():
	shoot_sound.play()

func _on_play_reload_sound():
	reload_sound.play()
