extends Node2D
@onready var note_detector = $"NoteDetector"
@onready var BlankFlute = $"BlankFlute"
@onready var flute_spawn_point: Marker2D = $MarkerFlute2D
@onready var label: Label = $CanvasLayer/Label
@onready var animated_sprite_direction = $TutorialNotes
@onready var animated_sprite_player = $TutorialPlayer
@onready var ui_scene: PackedScene = preload("res://UI/Recorder_UI/FluteUI.tscn")

const A_sharp_flute = preload('res://Sprites/note_sprites_godot/A#_flute.png')
const G_sharp_flute = preload('res://Sprites/note_sprites_godot/G#_flute.png')
const G_flute = preload('res://Sprites/note_sprites_godot/G_flute.png')
const F_flute = preload('res://Sprites/note_sprites_godot/F_flute.png')
const blank_flute = preload('res://Sprites/note_sprites_godot/blank_flute.png')

var current_step: int = 0
var required_action: String = ""

#this is to prevent ghost while loops
var current_flute_id: int = 0

var steps: Array[Dictionary] = [
	{
		'text' : 'Play an A# note',
		'note' : 'A#',
		'texture' : A_sharp_flute,
		'note_direction': 'A#left',
		'player_direction': 'left',
		'move_direction': -800,
		'position': position.x
	},
		{
		'text' : 'Play an F note',
		'note' : 'F',
		'texture' : F_flute,
		'note_direction': 'Fdown',
		'player_direction': 'down',
		'move_direction': -800,
		'position': position.y
	},
		{
		'text' : 'Play an G# note',
		'note' : 'G#',
		'texture' : G_sharp_flute,
		'note_direction': 'G#right',
		'player_direction': 'right',
		'move_direction': 800,
		'position': position.x
	},
		{
		'text' : 'Play an G note',
		'note' : 'G',
		'texture' : G_flute,
		'note_direction': 'Gup',
		'player_direction': 'up',
		'move_direction': 800,
		'position': position.y
	},
]


func _ready() -> void:
	#lauchs live FluteUI
	var instance := ui_scene.instantiate()
	add_child(instance)
	instance.global_position = flute_spawn_point.global_position
	
	#starts listening
	note_detector.detect_note_started.connect(on_note_started)
	start_step(0)

#finds the correct direction in note map and puts values in note_input()
func on_note_started(event: NoteDetectEvent) -> void:
	var step_data = steps[current_step]
	var note = event.note_name
	print("Note detected: ", note)
	if note == step_data['note']:
		animated_sprite_direction.visible = true
		animated_sprite_direction.play(step_data['note_direction'])
		advance_step()
	
func start_step(index : int):
	var while_id: int = current_flute_id
	
	#when index exceeds size of array, tutorial closes
	if index >= steps.size():
		end_tutorial()
		return
		
	current_step = index
	var step_data = steps[current_step]
	
	#assigns label from array to Label child node
	label.text = step_data['text']
	
	#starts flashing loop
	while current_step == while_id:
		BlankFlute.texture = step_data['texture']
		await get_tree().create_timer(0.75).timeout
		
		#this will break look if these two varables dont match
		if current_flute_id != while_id:
			break
		BlankFlute.texture = blank_flute
		await get_tree().create_timer(0.75).timeout

	print(while_id)
func advance_step():
	BlankFlute.texture = blank_flute
	#this will shut down the current while loop
	#so we dont have multiple loops going on at once
	current_flute_id += 1
	#player_movement()
	start_step(current_step + 1)

func player_movement(target_position: Vector2, Duration: float = 1.0):
	var step_data = steps[current_step]
	
	animated_sprite_player.play(step_data['player_direction'])
	var tween = create_tween()
	var target_x = step_data['position'] + step_data['move_direction']
	tween.tween_property(self, "position", target_x, 0.5)
	await tween.finished

func end_tutorial():
	pass
	#Delete "pass" and uncomment when testing is done
	#get_tree().change_scene_to_file('res://UI/main_menu.tscn')
