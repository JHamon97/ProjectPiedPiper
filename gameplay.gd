class_name Logic extends Node

#Note map of every note we want to use and its direction
const note_map = {
	"A#": "left_note",
	"G#": "right_note",
	"G": "up_note",
	"F": "down_note"
}
var old_note_direction = "NULL"
#link to NoteDetector
@onready var note_detector = $"NoteDetector"

func _ready() -> void:
	#connects to plugin
	note_detector.detect_note_started.connect(on_note_started)

#finds the correct direction in note map and puts values in note_input()
func on_note_started(event: NoteDetectEvent) -> void:
	var note = event.note_name
	print("Note detected: ", note)
	
	#Nested if statement, I dont like it but it works.
	if note in note_map:
		var note_direction = note_map[note]
		if old_note_direction == "NULL":
			note_input(note_direction, true)
		elif note_direction != old_note_direction:
			note_input(old_note_direction, false)
			note_input(note_direction, true)
		else:
			note_input(note_direction, true)
		old_note_direction = note_direction	
	else:
		pass

#Parses information in the parse_input_event. Makes custom input_map possible
func note_input(note_direction: String, is_pressed: bool) -> void:
	var event = InputEventAction.new()
	
	# Set as action_name, pressed.
	event.action = note_direction
	event.pressed = is_pressed
	
	Input.parse_input_event(event)
