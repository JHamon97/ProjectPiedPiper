extends CharacterBody2D
#var move_direction = up
const move_speed = 10
const note_map = {
	"B": "left_note"
}
var target_velocity = Vector2.ZERO
#var input_direction: float = 0.0
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
		
		#this turns off the note 
		note_input(note_direction, false)
	else:
		pass

	
func note_input(note_direction: String, is_pressed: bool) -> void:
	var event = InputEventAction.new()
	
	# Set as action_name, pressed.
	event.action = note_direction
	event.pressed = is_pressed
	
	Input.parse_input_event(event)

func _physics_process(delta: float) -> void:
	var input_direction = Vector2.ZERO
	#var move_direction = up
	if Input.is_action_just_pressed("left_note"):
		print("triggered")
		input_direction.x = -10.0
	target_velocity.x = move_speed * input_direction.x
	target_velocity.y = move_speed * input_direction.y
	velocity = target_velocity
	move_and_slide()
	
#func movement():
#	var input_direction = Vector2.ZERO
#	if Input.is_action_just_pressed("left_note"):
		#print("triggered")
#		input_direction.x = -1.0
		




#func update_velocity() -> void: 
#	velocity = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
#	#four directional movement
#	if velocity.x != 0:
#		velocity.y = 0
#	else:
#		velocity.x = 0
#	velocity = velocity.normalized()
