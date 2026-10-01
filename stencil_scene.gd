extends Node3D

@onready var portal_1: MeshInstance3D = $Portal
@onready var portal_2: MeshInstance3D = $Portal2
@onready var wall_left: CSGBox3D = $WallLeft
@onready var wall_back: CSGBox3D = $WallBack
@onready var area_3d_entrance: Area3D = $Area3DEntrance
@onready var ray_cast_3d: RayCast3D = $RayCast3D
@onready var ray_cast_3d_2: RayCast3D = $RayCast3D2

@onready var visible_on_screen_notifier_3d: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D

@onready var proto_controller: ProtoController = $ProtoController
@onready var footstep_audio_outdoor: AudioStreamPlayer3D = %FootstepAudioOutdoor
@onready var footstep_audio_indoor: AudioStreamPlayer3D = %FootstepAudioIndoor
@onready var interior_floor_collision: CollisionShape3D = $InteriorFloor/InteriorFloorCollision

func _process(_delta: float) -> void:
	if ray_cast_3d.is_colliding():
		if ray_cast_3d.get_collider() is ProtoController:
			portal_1.visible = true
	if ray_cast_3d_2.is_colliding():
		if ray_cast_3d_2.get_collider() is ProtoController:
			portal_1.visible = true
	if portal_2.visible:
		interior_floor_collision.disabled = false
		if proto_controller.ray_cast_3d.is_colliding():
			if proto_controller.ray_cast_3d.get_collider().is_in_group("Indoor"):
				proto_controller.footstep_audio = footstep_audio_indoor
	else:
		interior_floor_collision.disabled = true
		proto_controller.footstep_audio = footstep_audio_outdoor
	#print(str(Engine.get_frames_per_second()))

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is ProtoController:
		if body.global_position.x > area_3d_entrance.global_position.x:
			if portal_1.visible:
				portal_2.visible = true
				wall_left.use_collision = true
				wall_back.use_collision = true
		else:
			if !portal_2.visible:
				portal_1.visible = false


func _on_area_3d_entrance_body_exited(body: Node3D) -> void:
	if body.global_position.x > area_3d_entrance.global_position.x:
		if portal_2.visible:
			portal_2.visible = false
			wall_left.use_collision = false
			wall_back.use_collision = false


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	portal_1.visible = true


func _on_exit_1_body_entered(body: Node3D) -> void:
	if body is ProtoController:
		portal_1.visible = true

func _on_exit_2_body_entered(body: Node3D) -> void:
	if body is ProtoController:
		portal_1.visible = true
