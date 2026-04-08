extends Control

signal action_selected
export var a = 1

func _ready():
	pass 

func load_action(_action_data):
	pass
	#print('loaded')
	

func _on_ActionUI_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("action_selected")
			#print('aa')

