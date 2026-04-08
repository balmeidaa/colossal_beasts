extends Control

signal action_selected
export var a = 1
var root_menu = null

func _ready():
	pass 

func load_action(_action_data, menu_node):
	root_menu = menu_node
	pass
	#print('loaded')
	

func _on_ActionUI_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("action_selected")
			if root_menu:
				root_menu.toggle_menu()
			#print('aa')

