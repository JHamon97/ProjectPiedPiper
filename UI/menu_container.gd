extends VBoxContainer

var menu_items: Dictionary = {
	'Tutorial': _on_tut_button_pressed,
	 'Start': _on_start_button_pressed,
	 'End': _on_quit_button_pressed
	}

func _ready() -> void:
	button_dict(menu_items)
	
func button_dict(dict: Dictionary) -> void:
	for item in dict:
		var btn = Button.new()
		btn.text = str(item)
		btn.pressed.connect(menu_items[item])
		add_child(btn)

func _on_tut_button_pressed() -> void:
	pass

func _on_start_button_pressed() -> void:
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
