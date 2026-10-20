class_name Player extends CharacterBody2D
const speed:int = 50
#func _ready() -> void:
#	print("A")
	
func _process(delta: float) -> void:
	#Input.flush_buffered_events() (maybe important)
	get_vector()

func get_vector():
	var input_vector = Input.get_vector("left_note", "right_note", "up_note", "down_note")
	velocity = input_vector * speed
	print(input_vector)
	move_and_slide()
