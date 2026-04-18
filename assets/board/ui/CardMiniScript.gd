extends TextureRect
 
onready var action_mini = $ActionMini
onready var initiative = $Initiative

var initiative_rank = 0
var card_owner = null

func load_mini(action_dat, initiative_order, new_owner = 'player'):
	card_owner = new_owner
	var card_image = action_dat['card_played'].get_img_card()
	var img_card = GameData.card_img_path % card_image
	var action_icon = GameData.action_icon_path % action_dat['action_icon']
	
	##carga textura de creatura y icono de action
	texture = load(img_card)
	action_mini.texture = load(action_icon)
	update_initiative_order(initiative_order)


func _on_CardMini_gui_input(event):
	#agregar validacion y solo aceptar si el jugador hizo click en su propia cola de acciones
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and card_owner == 'player':
			GameHandler.action_queue.remove_mini_at(initiative_rank)

func update_initiative_order(new_order):
	initiative_rank = new_order
	initiative.text = String(new_order)
