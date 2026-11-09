class_name Player extends CharacterBody2D
const speed:int = 1
const grid_size = 64
var current_direction: Vector2 = Vector2.RIGHT  # Starting direction
var next_direction: Vector2 = Vector2.RIGHT     # Buffered next direction

#var current_direction: Vector2 = Vector2.RIGHT  # Starting direction
#var next_direction: Vector2 = Vector2.RIGHT  

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	position = position.snapped(Vector2.ONE * grid_size)
	direction_loop()


func  _unhandled_input(event: InputEvent) -> void:
	next_direction = Input.get_vector("left_note", "right_note", "up_note", "down_note")


func direction_loop() -> void:
	while true:
		current_direction = next_direction
		if current_direction.y == 1:
			animated_sprite.play("down")
		elif current_direction.y == -1:
			animated_sprite.play("up")
		elif current_direction.x == -1:
			animated_sprite.play("left")
		elif current_direction.x == 1:
			animated_sprite.play("right")
		await grid_move()

func grid_move() -> void:
	var target_position = position + (grid_size * current_direction)
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 0.5)
	await tween.finished
	
