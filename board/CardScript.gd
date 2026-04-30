extends Sprite3D

export var desired_world_height  := 12.0 #deprecate
onready var action_menu = $ActionMenu
onready var display_ui = $DisplayViewport/CardDisplay

var actions_remaining = 2
var card_info = {}
## TODO
## mejorar esta estructura
## HUD para defensa y puntos de salud, puntos de accion
var modifiers = {}



func _ready():
	pass
	##deprecado
	# cambiar tamaño de la textura
	#var img_h = texture.get_height() 
	#pixel_size = desired_world_height / img_h ##deprecated


func load_card(card_name, entity):
	card_info = GameData.card_list[card_name].duplicate()
	var card_texture = GameData.load_card_texture(card_info['image'])
	texture = load(card_texture)
	## no cargar acciones si no es carta del jugador <<<
	if entity == 'player':
		action_menu.load_actions_ui(card_info['action_moveset'])
	##cargar puntos de salud si es de un juego previo
	## si es primera partida usar puntos base
	if not card_info.has('current_hp'):
		card_info['current_hp'] = card_info['base_hitpoints']
	
	card_info['defense'] = 0
	display_ui.set_owner_card(self)
	display_ui.update_all()


##si target solver esta activo devolver este nodo a target solver
func _on_ClickableArea_input_event(_camera, event, _position, _normal, _shape_idx):
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				if GameHandler.target_solver.input_active:
					GameHandler.target_solver.selected_target = self
				elif self.is_in_group('player_cards') and can_play_action():
					action_menu.toggle_menu()
	return null

func can_play_action():
	return true if actions_remaining > 0 else false

func decrease_actions_remaining():
	if can_play_action():
		actions_remaining = actions_remaining - 1
		display_ui.update_stats()
	else: ## debug porposes
		print('bugsote')
		
func reset_actions_remaining():
	actions_remaining = 2
	display_ui.update_stats()


func get_img_card():
	return card_info['image']
	
func increase_defense(amount):
	card_info['defense'] = card_info['defense'] + amount
	display_ui.update_stats()

	
func recieve_damage(damage):
	var defense = card_info['defense']
	var hp = card_info['current_hp']
	defense = defense - damage
	
	if defense < 0: ## el daño es mayor que la defensa, el restante se descuenta a la salud
		hp = hp + defense
		defense = 0
	
	card_info['defense'] = defense
	card_info['current_hp'] = hp
	# despues checar si esta morido esta carta
	display_ui.update_stats()

	
#para hacerla reutilizable con varios filtros
func filter_modifier(list, key):
	var mod_list = []
	for item in list:
		if item.has(key):
			mod_list.append(item)
	return mod_list
	
	
 

