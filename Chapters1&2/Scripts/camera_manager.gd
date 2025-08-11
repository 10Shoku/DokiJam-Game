extends Node

@export var main_camera : PhantomCamera2D

@export var interaction_area_1 : Area2D
@export var interaction_area_2 : Area2D
@export var interaction_area_3 : Area2D
@export var interaction_area_4 : Area2D
@export var interaction_area_5 : Area2D
@export var interaction_area_6 : Area2D
@export var interaction_area_7 : Area2D

@export var camera_1 : PhantomCamera2D
@export var camera_2 : PhantomCamera2D
@export var camera_3 : PhantomCamera2D
@export var camera_4 : PhantomCamera2D
@export var camera_5 : PhantomCamera2D
@export var camera_6 : PhantomCamera2D
@export var camera_7 : PhantomCamera2D

var is_interacting := false
var current_interaction_area : Area2D


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact"):
		if is_interacting:
			is_interacting = false
			update_camera()
			main_camera.priority = 1
		else:
			find_interaction()


func find_interaction():
	var interaction_areas : Array[Area2D] = [
		interaction_area_1,
		interaction_area_2,
		interaction_area_3,
		interaction_area_4,
		interaction_area_5,
		interaction_area_6,
		interaction_area_7
	]
	current_interaction_area = null
	
	for interaction_area in interaction_areas:
		if current_interaction_area == null:
			var overlapping_bodies := interaction_area.get_overlapping_bodies()
			
			for overlapping_body in overlapping_bodies:
				if overlapping_body.is_in_group("doki"):
					current_interaction_area = interaction_area
					is_interacting = true
					update_camera()


func update_camera():
	var cameras : Array[PhantomCamera2D] = [
		camera_1,
		camera_2,
		camera_3,
		camera_4,
		camera_5,
		camera_6,
		camera_7
	]
	
	for camera in cameras:
		if camera != null:
			camera.priority = 0
	
	match current_interaction_area:
		interaction_area_1:
			camera_1.priority = 1
		interaction_area_2:
			camera_2.priority = 1
		interaction_area_3:
			camera_3.priority = 1
		interaction_area_4:
			camera_4.priority = 1
		interaction_area_5:
			camera_5.priority = 1
		interaction_area_6:
			camera_6.priority = 1
		interaction_area_7:
			camera_7.priority = 1
