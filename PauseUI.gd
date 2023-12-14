extends CanvasLayer

var is_paused:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.pause_game.connect(pause)
	Events.unpause_game.connect(unpause)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"): 
		if is_paused:
			$".".visible = false
			unpause()
		else:
			$".".visible = true
			pause()


func _on_continue_pressed():
	print("PAUSE")
	visible = false
	unpause()
	is_paused = false
	Events.unpause_game.emit()
	$"..".get_tree().paused = false

func _on_exit_pressed():
	get_tree().quit()
	
func pause():
	visible = true
	is_paused = true
	$"..".get_tree().paused = true

func unpause():
	is_paused = false
	visible = false
	$"..".get_tree().paused = false


func _on_settings_pressed():
	$SettingsUI.visible = true


func _on_menu_pressed():
		get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
