extends CanvasLayer

onready var tween = $Tween
#si algo sale mal cambiar a nodo control
onready var control_ui = $Control
onready var vbox_ui = $Control/Panel/Scroll/VBox

var actionUI := preload("res://board/card_ui/ActionUI.tscn")

export var anim_time := 1.0

var viewport_size: Vector2
var is_showing = false
# usar valores fijos al mover el menu para evitar bugs al desplegarlo
var hide_pos := 0.0
var show_pos := 0.0

func _ready():
# TODO  Si este menu no pertenece al jugador, esconder menu
	viewport_size = get_viewport().size
	control_ui.rect_position.x =  - viewport_size.x 
	hide_pos = control_ui.rect_position.x -  viewport_size.x
	show_pos = control_ui.rect_position.x +  viewport_size.x
	


func _process(_delta):
# TODO  Si este menu no pertenece al jugador, desactivarlo
	if Input.is_action_pressed("ui_cancel") and is_showing:
		toggle_menu()
	
func load_actions_ui(card_actions):
	var card_node = get_parent()  
	for action in card_actions:
		var new_action_ui = actionUI.instance()
		var action_data = GameData.action_list[action]
		vbox_ui.add_child(new_action_ui)
		new_action_ui.load_action(action_data, card_node, self)
		

func get_all_ui_actions():
	return vbox_ui.get_children()
	
func toggle_menu():
	is_showing = !is_showing
	GameHandler.update_ui_action_menu(self)
	
	if is_showing:
		show_menu()
	else:
		hide_menu()

func show_menu():
	tween.interpolate_property(control_ui, "rect_position:x",
		control_ui.rect_position.x, show_pos, anim_time,
		Tween.TRANS_CIRC, Tween.EASE_OUT)
	tween.start()

func hide_menu():
	tween.interpolate_property(control_ui, "rect_position:x",
		control_ui.rect_position.x, hide_pos, anim_time,
		Tween.TRANS_CIRC, Tween.EASE_IN)
	tween.start()

func get_rect_size():
	return $Control.rect_size
