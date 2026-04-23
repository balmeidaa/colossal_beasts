extends VBoxContainer

signal container_resized

func _on_EffectsContainer_resized():
	emit_signal("container_resized", rect_size)
