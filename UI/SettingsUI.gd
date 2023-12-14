extends Control

func _on_main_slider_value_changed(value):
	AudioServer.set_bus_volume_db(0,linear_to_db(value))

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(1,linear_to_db(value))

func _on_effects_slider_value_changed(value):
	AudioServer.set_bus_volume_db(2,linear_to_db(value))

func _on_exit_pressed():
	if visible==true:
		visible = false
