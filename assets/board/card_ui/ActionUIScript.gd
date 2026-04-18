extends Control

signal action_selected

var root_menu = null
var action_taken = {
	"card_played": null,
	"objetive": null, #objeto en juego
	"objective_type": null,#tipo de objetivo
	"action_icon": null,
	"script_name": ''
}


####UI
onready var title_label = $HBoxContainer/Title
onready var icon_img = $HBoxContainer/Icon

func _ready():

	##conectarse a otro nodo que se encarge de manejar objetivos (i.e. movimiento, enemigos , etc)
	connect("action_selected", GameHandler.target_solver, "acquire_target")
	##auto conectarse

func load_action(action_data, card_node, menu_node):
	
	action_taken["card_played"] = card_node
	action_taken["action_icon"] = action_data["icon"]
	action_taken["script_name"] = action_data["script_name"]
	action_taken["objective_type"] = action_data["objective"]
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


