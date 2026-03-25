extends Control

signal action_clicked
export var a = 1

func _ready():
	pass # Replace with function body.


func _on_ActionUI_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			#emit_signal("action_clicked")
			print(a)
