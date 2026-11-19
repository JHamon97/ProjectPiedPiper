extends VBoxContainer

#var packed_devices = AudioServer.get_input_device_list()
var unpacked_devices: Array[String] = Array( Array(AudioServer.get_input_device_list()), TYPE_STRING, "", null )

func _ready() -> void:
	button_array(unpacked_devices)
	
func button_array(array: Array) -> void:
	for item in array:
		print(item)
		var btn = Button.new()
		btn.text = str(item)
		# btn.pressed.connect(insert button path)
		add_child(btn)
