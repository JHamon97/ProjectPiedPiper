extends CharacterBody2D
#all of this can be replaced by April
@onready var sprite: Sprite2D = $Sprite2D

var _target_pos: Vector2

func set_up(sprite_texture: String) -> void:
	while !sprite:
		await get_tree().phystics_frame
	sprite.texture = load(sprite_texture)

func _physics_process(delta: float) -> void:
	if global_position != _target_pos:
		var dir: Vector2 = (_target_pos - global_position).normalized()
		if dir.x != 0:
			sprite.flip.h = dir.x < 0
		
		global_position = _target_pos
