extends CharacterBody2D

const speed = 10
const note_map = {
	"B": "left_note"
}
#const SPEED = 300.0
#var input: Vector2

@onready var note_detector = $NoteDetector

func _ready() -> void:
	note_detector.detect_note_started.connect(on_note_started)


func on_note_started(event: NoteDetectEvent) -> void:
	var note = event.note_name
	print("Note detected: ", note)
	if note in note_map:
		var note_direction = note_map[note]
		note_input(note_direction, true)
	else:
		pass

	
func note_input(note_direction: String, is_pressed: bool) -> void:
	var event = InputEventAction.new()
	
	# Set as action_name, pressed.
	event.action = note_direction
	event.pressed = is_pressed
	
	Input.parse_input_event(event)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("left_note"):
			print("wowowowowo")
#func unhandled_input(event)-> void:
#	Input.get_vector("left_note","right_note","down_note","up_note")
#	if event.is_action_pressed("left_note"):
#		print("left_note has been sounded.")



#func update_velocity() -> void: 
#	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
#	#four directional movement
#	if velocity.x != 0:
#		velocity.y = 0
#	else:
#		velocity.x = 0
#	velocity = velocity.normalized()
