extends PanelContainer

func _on_basic_pressed() -> void:
	var success = get_tree().change_scene_to_file("res://test_2d.tscn")
	print("changed to success",success)
	pass # Replace with function body.


func _on_custom_pressed() -> void:
	var success = get_tree().change_scene_to_file("res://node_editor.tscn")
	print("changed to success",success)

	pass # Replace with function body.


func _on_info_pressed() -> void:
	pass # Replace with function body.
