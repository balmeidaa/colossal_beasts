extends Control

signal action_selected

var action_taken = {
	"card_node":null,
	"action_info":null
	
}
var root_menu = null

####UI
onready var title_label = $HBoxContainer/Title
onready var icon_img = $HBoxContainer/Icon

func _ready():
	pass 

func load_action(action_data, card_node, menu_node):
	
	action_taken["card_node"] = card_node
	action_taken["action_info"] = action_data
	root_menu = menu_node
	
	var icon_path = GameData.action_icon_path % action_data['icon']
	title_label.text = action_data['name']
	icon_img.texture = load(icon_path)
	

func _on_ActionUI_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("action_selected", action_taken) #cablear estas señales a un handler de accion del turno
			if root_menu:
				root_menu.toggle_menu()


