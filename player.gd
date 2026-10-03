extends CharacterBody2D

const speed = 10
#const SPEED = 300.0
#var input: Vector2

@onready var note_detector = $NoteDetector

func _ready() -> void:
	note_detector.detect_note_started.connect(on_note_started)

func on_note_started(event: NoteDetectEvent):
# -> void:
	print("Note detected: ", event.note_name)
	var note = event.note_name
	return note

func event_trigger(note,note_name,action_name):
	note_name = on_note_started(note)
	if note_name == "C":
		action_name = "note_left"
	_trigger_action(action_name, true)
	
func _trigger_action(action_name, is_pressed):
	var ev = InputEventAction.new()
	# Set as left_note, pressed.
	ev.action = action_name
	ev.pressed = is_pressed
	Input.parse_input_event(ev)
	
func _unhandled_input(event):
	Input.get_vector("left_note","right_note","down_note","up_note")
	if event.is_action_pressed("left_note"):
		print()


#func update_velocity() -> void: 
#	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
#	#four directional movement
#	if velocity.x != 0:
#		velocity.y = 0
#	else:
#		velocity.x = 0
#	velocity = velocity.normalized()
