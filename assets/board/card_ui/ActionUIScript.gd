extends Control

signal action_selected

var root_menu = null
const format_path  = 'res://assets/icons/%s.png'

var action_info = null
####UI
onready var title_label = $HBoxContainer/Title
onready var icon_img = $HBoxContainer/Icon

func _ready():
	pass 

func load_action(action_data, menu_node):
	root_menu = menu_node
	action_info = action_data
	var icon_path = format_path % action_info['icon']
	title_label.text = action_info['name']
	icon_img.texture = load(icon_path)
	

func _on_ActionUI_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("action_selected")
			if root_menu:
				root_menu.toggle_menu()


