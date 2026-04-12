extends Control

signal action_selected

var root_menu = null
var action_taken = {
	"card_entity": null,
	"action_icon": null,
	"script_name": ''
}


####UI
onready var title_label = $HBoxContainer/Title
onready var icon_img = $HBoxContainer/Icon

func _ready():
	add_to_group("actions_available")
	connect("action_selected", GameHandler.action_queue, "add_ui_action_Q")
	##auto conectarse

func load_action(action_data, card_node, menu_node):
	
	action_taken["card_entity"] = card_node
	action_taken["action_icon"] = action_data["icon"]
	action_taken["script_name"] = action_data["script_name"]
	root_menu = menu_node
	
	title_label.text = action_data['name']
	var icon_path = GameData.load_action_texture(action_data['icon'])
	icon_img.texture = load(icon_path)
	

func _on_ActionUI_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("action_selected", action_taken) #cablear estas señales a un handler de accion del turno
			if root_menu:
				root_menu.toggle_menu()


