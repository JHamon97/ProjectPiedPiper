extends VBoxContainer


var packed_devices = AudioServer.get_input_device_list()
var unpacked_devices: Array[String] = Array(Array(AudioServer.get_input_device_list()), TYPE_STRING, "", null)
#var scene_path = 'res://UI/main_menu.tscn'
func _ready() -> void:
	button_array(unpacked_devices)
	
func button_array(array: Array) -> void:
	var i = 0
	for item in array:
		var btn = Button.new()
		btn.text = str(item)
		btn.pressed.connect(_on_level_button_pressed.bind('res://UI/main_menu.tscn', i))
		add_child(btn)
		i += 1
func _on_level_button_pressed(scene_path: String, number: int) -> void:
	AudioServer.input_device = packed_devices[number]
	get_tree().change_scene_to_file(scene_path)
