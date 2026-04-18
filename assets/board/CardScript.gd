extends Sprite3D

export var desired_world_height  := 12.0 #deprecate
onready var action_menu = $ActionMenu

var card_info = {}

func _ready():
	pass
	##deprecado
	# cambiar tamaño de la textura
	#var img_h = texture.get_height() 
	#pixel_size = desired_world_height / img_h ##deprecated


func load_card(card_name, entity):
	card_info = GameData.card_list[card_name].duplicate()
	var card_texture = GameData.load_card_texture(card_info['icon'])
	texture = load(card_texture)
	## no cargar acciones si no es carta del jugador <<<
	if entity == 'player':
		action_menu.load_actions_ui(card_info['action_moveset'])

##si target solver esta activo devolver este nodo a target solver
func _on_ClickableArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				if GameHandler.target_solver.input_active:
					GameHandler.target_solver.selected_target = self
				elif  self.is_in_group('player_cards'):
					action_menu.toggle_menu()
	return null


func get_img_card():
	return card_info['icon']
