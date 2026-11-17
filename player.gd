class_name Player extends CharacterBody2D
const speed:int = 0.25
const grid_size = 64
const RAT_SCENE_PRELOAD = preload("res://rat.tscn")

var current_direction: Vector2 = Vector2.RIGHT  # Starting direction
var next_direction: Vector2 = Vector2.RIGHT     # Buffered next direction
var followers: Array[Node2D] = []
var distance_spacing: int = 1
var _trail_points: Array[Vector2] = []

#var current_direction: Vector2 = Vector2.RIGHT  # Starting direction
#var next_direction: Vector2 = Vector2.RIGHT  

@onready var animated_sprite_player = $AnimatedSprite2D
@onready var animated_sprite_direction = $Note_direction

func _ready() -> void:
	position = position.snapped(Vector2.ONE * grid_size)
	spawn_follower("")
	direction_loop()


func  _unhandled_input(event: InputEvent) -> void:
	next_direction = Input.get_vector("left_note", "right_note", "up_note", "down_note")


func direction_loop() -> void:
	while true:
		current_direction = next_direction
		if current_direction.y == 1:
			animated_sprite_player.play("down")
			animated_sprite_direction.play("Fdown")
			follower_logic()
		elif current_direction.y == -1:
			animated_sprite_player.play("up")
			animated_sprite_direction.play("Gup")
			follower_logic()
		elif current_direction.x == -1:
			animated_sprite_player.play("left")
			animated_sprite_direction.play("A#left")
			follower_logic()
		elif current_direction.x == 1:
			animated_sprite_player.play("right")
			animated_sprite_direction.play("G#right")
			follower_logic()
		await grid_move()

func grid_move() -> void:
	var target_position = position + (grid_size * current_direction)
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 0.5)
	await tween.finished

func follower_logic() -> void:
	if followers.is_empty:
		return
	_trail_points.push_front(global_position)
	var max_trail_points = (followers.size() + 1) * distance_spacing
	while _trail_points.size() > max_trail_points:
		_trail_points.pop_back()
	for i in followers.size():
		var trail_index = (i + 1) * distance_spacing
		if trail_index < _trail_points.size():
			followers[i]._target_pos = _trail_points[trail_index]

func spawn_follower(sprite_texture: String, spawn_dir: Vector2 = Vector2.DOWN) -> void:
	var new_follower_scene: Node2D = RAT_SCENE_PRELOAD.instantiate()
	
	var base_pos: Vector2 = global_position
	if followers.size() > 0:
		base_pos = followers.back().global_position
	var spawn_pos: Vector2 = base_pos + (spawn_dir * grid_size)
	
	if _trail_points.is_empty():
		_trail_points.append(global_position)
	
	new_follower_scene.global_position = spawn_pos
	new_follower_scene._target_pos = spawn_pos
	_trail_points.append(spawn_pos)
	
	get_parent().add_child.call_deferred(new_follower_scene)
	new_follower_scene.set_up.call_deferred(sprite_texture)
	
	followers.append(new_follower_scene)
	
	
	
