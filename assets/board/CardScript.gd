extends Sprite3D

export var desired_world_height  := 12.0
onready var action_menu = $ActionMenu
 
var first_time = true ## debug

func _ready():
	# cambiar tamaño de la textura
	var img_h = texture.get_height() 
	pixel_size = desired_world_height / img_h

## para evitar bugs 
## crear instancia
## agregar instancia
## cargar datos
func _process(_delta):
	if first_time: #debug only
		init_card_ui()
		first_time = false
	

func init_card_ui():
	load_action_menu()
	#action_menu.connect_actions() #provisional mientras se aun no se carga info desde archivo


func _on_ClickableArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			action_menu.toggle_menu()
			

		
func load_action_menu():
	var card_actions = ['move','claw_swipe'] #test purposes
	action_menu.load_actions_ui(card_actions)
