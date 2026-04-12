extends Sprite3D

export var desired_world_height  := 12.0 #deprecate
onready var action_menu = $ActionMenu
 
var first_time = true ## debug
var card_info = {}

func _ready():
	pass
	##deprecado
	# cambiar tamaño de la textura
	#var img_h = texture.get_height() 
	#pixel_size = desired_world_height / img_h ##deprecated

## para evitar bugs 
## 1. crear instancia
## 2. agregar instancia
## 3. cargar datos
func _process(_delta):
	if first_time: #for testing only
		init_card_ui()
		first_time = false
	

func load_card(card_data):
	card_info = card_data
	var card_texture = GameData.load_card_texture(card_info['icon'])
	texture = load(card_texture)
	## no cargar acciones si no es carta del jugador <<<
	action_menu.load_actions_ui(card_info['action_moveset'])


func _on_ClickableArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			action_menu.toggle_menu()


## tests purposes only	
func init_card_ui():
	load_action_menu()
		
func load_action_menu():
	var card_actions = ['move','claw_swipe'] #test purposes
	action_menu.load_actions_ui(card_actions)

func get_img_card():
	return card_info['icon']
