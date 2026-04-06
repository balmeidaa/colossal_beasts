extends CanvasLayer

onready var tween = $Tween
#si algo sale mal cambiar a nodo control
onready var control_ui = $Control
onready var vbox_ui = $Control/Panel/Scroll/VBox

var actionUI := preload("res://assets/board/card_ui/ActionUI.tscn")

export var anim_time := 1.0

var viewport_size: Vector2
var is_hiding = true
# usar valores fijos al mover el menu para evitar bugs al desplegarlo
var hide_pos := 0.0
var show_pos := 0.0

func _ready():
	viewport_size = get_viewport().size
	control_ui.rect_position.x =  - viewport_size.x 
	hide_pos = control_ui.rect_position.x -  viewport_size.x
	show_pos = control_ui.rect_position.x +  viewport_size.x
	
 
	

func _process(_delta):

	if Input.is_action_pressed("ui_cancel") and not is_hiding:
		toggle_menu()
	
func load_actions_ui(_card_actions):
	#cargar de archivo acciones
	#for action in card_actions:
	for _i in range(0,4):
		var new_action_ui = actionUI.instance()
		new_action_ui.load_action("action_data")
		vbox_ui.add_child(new_action_ui)
	
func connect_actions():
	var ui_actions = get_all_ui_actions()
	for action in ui_actions:
		action.connect("action_selected", self, "toggle_menu")

func get_all_ui_actions():
	return vbox_ui.get_children()
	
func toggle_menu():
	is_hiding = !is_hiding
	
	if is_hiding:
		hide_menu()
	else:
		show_menu()

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

