extends Control
@onready var note_detector = $"NoteDetector"
@onready var BlankFlute = $"BlankFlute"
const A_sharp_flute = preload('res://Sprites/note_sprites_godot/A#_flute.png')
const G_sharp_flute = preload('res://Sprites/note_sprites_godot/G#_flute.png')
const G_flute = preload('res://Sprites/note_sprites_godot/G_flute.png')
const F_flute = preload('res://Sprites/note_sprites_godot/F_flute.png')
const blank_flute = preload('res://Sprites/note_sprites_godot/blank_flute.png')

func _ready() -> void:
	#connects to plugin
	note_detector.detect_note_started.connect(on_note_started)
	note_detector.detect_note_stopped.connect(on_note_ended)

func on_note_started(event: NoteDetectEvent) -> void:
	var note = event.note_name
	print(note)
	if event.note_name == 'A#' or event.note_name == 'B':
		BlankFlute.texture = A_sharp_flute
	elif event.note_name == 'G#' or event.note_name == 'A':
		BlankFlute.texture = G_sharp_flute
	elif event.note_name == 'G' or event.note_name == 'F#':
		BlankFlute.texture = G_flute
	elif event.note_name == 'F' or event.note_name == 'E':
		BlankFlute.texture = F_flute
		#note_detector.detect_note_stopped.connect(on_note_ended)

func on_note_ended(_event: NoteDetectEvent) -> void:
	print("Note stopped")
	BlankFlute.texture = blank_flute
