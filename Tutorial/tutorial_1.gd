extends Node2D
@onready var note_detector = $"NoteDetector"
@onready var BlankFlute = $"BlankFlute"
const A_sharp_flute = preload('res://Sprites/note_sprites_godot/A#_flute.png')
const G_sharp_flute = preload('res://Sprites/note_sprites_godot/G#_flute.png')
const G_flute = preload('res://Sprites/note_sprites_godot/G_flute.png')
const F_flute = preload('res://Sprites/note_sprites_godot/F_flute.png')

func _ready() -> void:
	#connects to plugin
	note_detector.detect_note_started.connect(on_note_started)

#finds the correct direction in note map and puts values in note_input()
func on_note_started(event: NoteDetectEvent) -> void:
	var note = event.note_name
	print("Note detected: ", note)
	if event.note_name == 'A#':
		BlankFlute.texture = A_sharp_flute
