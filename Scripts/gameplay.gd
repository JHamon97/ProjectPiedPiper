class_name Logic extends Node
const A_sharp_flute = preload('res://Sprites/note_sprites_godot/A#_flute.png')
const G_sharp_flute = preload('res://Sprites/note_sprites_godot/G#_flute.png')
const G_flute = preload('res://Sprites/note_sprites_godot/G_flute.png')
const F_flute = preload('res://Sprites/note_sprites_godot/F_flute.png')

#Note map of every note we want to use and its direction
const note_map = {
	"A#": "left_note",
	"B": "left_note",
	"G#": "right_note",
	"G": "up_note",
	"F": "down_note"
}
var old_note_direction = "NULL"
#link to NoteDetector
@onready var note_detector = $"NoteDetector"
@onready var BlankFlute = $"BlankFlute"

func _ready() -> void:
	#connects to plugin
	note_detector.detect_note_started.connect(on_note_started)

#finds the correct direction in note map and puts values in note_input()
func on_note_started(event: NoteDetectEvent) -> void:
	var note = event.note_name
	print("Note detected: ", note)
	
	#Im not sure if we can merge this into the
	#note input without breaking somthing.
	if event.note_name == 'A#' or event.note_name == 'B':
		BlankFlute.texture = A_sharp_flute
	if event.note_name == 'G#':
		BlankFlute.texture = G_sharp_flute
	if event.note_name == 'G':
		BlankFlute.texture = G_flute
	if event.note_name == 'F':
		BlankFlute.texture = F_flute			
	#Nested if statement, I dont like it but it works.
	if note in note_map:
		var note_direction = note_map[note]
		if old_note_direction == "NULL":
			note_input(note_direction, true)
			old_note_direction = note_direction
		elif old_note_direction == "left_note" and note_direction == "right_note" or old_note_direction == "right_note" and note_direction == "left_note":
			#note_input(note_direction, false)
			pass
		elif old_note_direction == "up_note" and note_direction == "down_note" or old_note_direction == "down_note" and note_direction == "up_note":
			#note_input(note_direction, false)
			pass
		elif note_direction != old_note_direction:
			note_input(old_note_direction, false)
			note_input(note_direction, true)
			old_note_direction = note_direction
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
