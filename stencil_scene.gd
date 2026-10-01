extends Node3D

@onready var portal_1: MeshInstance3D = $Portal
@onready var portal_2: MeshInstance3D = $Portal2
@onready var wall_left: CSGBox3D = $WallLeft
@onready var wall_back: CSGBox3D = $WallBack
@onready var area_3d_entrance: Area3D = $Area3DEntrance

@onready var visible_on_screen_notifier_3d: VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D

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


#func _on_area_3d_body_exited(body: Node3D) -> void:
	#if body is ProtoController:
		#portal_2.visible = false


func _on_area_3d_exit_body_exited(body: Node3D) -> void:
	if body is ProtoController:
		portal_2.visible = false
		wall_left.use_collision = false
		wall_back.use_collision = false
		if !visible_on_screen_notifier_3d.is_on_screen():
			portal_1.visible = true


func _on_visible_on_screen_notifier_3d_screen_entered() -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_3d_screen_exited() -> void:
	portal_1.visible = true


func _on_exit_1_body_entered(body: Node3D) -> void:
	portal_1.visible = true


func _on_exit_2_body_entered(body: Node3D) -> void:
	portal_1.visible = true
