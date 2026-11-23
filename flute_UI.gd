extends Sprite2D
@onready var note_detector = $"NoteDetector"
@onready var BlankFlute = $"BlankFlute"
#This is to make the flute UI 100% responsive to NoteDetector

#Sprites preloaded
const A_sharp_flute = preload('res://Sprites/note_sprites_godot/A#_flute.png')
const G_sharp_flute = preload('res://Sprites/note_sprites_godot/G#_flute.png')
const G_flute = preload('res://Sprites/note_sprites_godot/G_flute.png')
const F_flute = preload('res://Sprites/note_sprites_godot/F_flute.png')

const note_map = {
	"A#": "left_note",
	"B": "left_note",
	"G#": "right_note",
	"G": "up_note",
	"F": "down_note"
	}
	

func _ready() -> void:
	note_detector.detect_note_started.connect(on_note_started)
	#note_detector.detect_note_stopped.connect(on_note_stopped)
	
func on_note_started(event: NoteDetectEvent) -> void:
	var note = event.note_name
	print("Note detected: ", note)
	#if note in note_map:
	if event.note_name == 'A#' or event.note_name == 'B':
		BlankFlute.texture = A_sharp_flute
	elif event.note_name == 'G#':
		BlankFlute.texture = G_sharp_flute
	elif event.note_name == 'G':
		BlankFlute.texture = G_flute
	elif event.note_name == 'F':
		BlankFlute.texture = F_flute
	else:
		note_detector.detect_stopped
	
#detect_note_stopped(event: NoteDetectEvent): Emitted when a note is no longer detected.
#detect_stopped: Emitted when the note detector stops detecting notes (silence).
	
func note_input(note_direction: String, is_pressed: bool) -> void:
	var event = InputEventAction.new()
	
	# Set as action_name, pressed.
	event.action = note_direction
	event.pressed = is_pressed
	
	Input.parse_input_event(event)
