extends Node3D

@onready var portal_2: MeshInstance3D = $Portal2
@onready var wall_left: CSGBox3D = $WallLeft
@onready var wall_back: CSGBox3D = $WallBack


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is ProtoController:
		portal_2.visible = true
		wall_left.use_collision = true
		wall_back.use_collision = true


#func _on_area_3d_body_exited(body: Node3D) -> void:
	#if body is ProtoController:
		#portal_2.visible = false


func _on_area_3d_exit_body_exited(body: Node3D) -> void:
	if body is ProtoController:
		portal_2.visible = false
		wall_left.use_collision = false
		wall_back.use_collision = false
