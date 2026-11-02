class_name Player extends CharacterBody2D
const speed:int = 1
const grid_size = 64
var current_direction: Vector2 = Vector2.RIGHT  # Starting direction
var next_direction: Vector2 = Vector2.RIGHT     # Buffered next direction

func _ready() -> void:
	position = position.snapped(Vector2.ONE * grid_size)
	direction_loop()
	
#func _process(delta: float) -> void:
	#Input.flush_buffered_events() (maybe important)
	#direction_loop()
	

func  _unhandled_input(event: InputEvent) -> void:
	next_direction = Input.get_vector("left_note", "right_note", "up_note", "down_note")
	#velocity = input_vector * speed
	#print(input_vector)
	#move_and_slide()
	
func direction_loop() -> void:
	while true:
		current_direction = next_direction
		await grid_move()

func grid_move() -> void:
	var target_position = position + (grid_size * current_direction)
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 0.5)
	await tween.finished
	
