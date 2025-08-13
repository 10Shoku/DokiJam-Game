# level_config.gd
extends Resource
class_name LevelConfig  # Register as a class

@export var fall_death_offset: float = 3000
@export var background_music: AudioStream
@export var spawn_points: Array[Vector2]
