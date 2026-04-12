extends TextureRect

signal mini_clicked

onready var action_mini = $ActionMini
onready var initiative = $Initiative


func load_mini(action_dat, initiative):
	var card_image = action_dat['card_entity'].get_img_card()
	var img_card = GameData.card_img_path % card_image
	var action_icon = GameData.action_icon_path % action_dat['action_icon']
	
	##carga textura de creatura y icono de action
	texture = load(img_card)
	action_mini.texture = load(action_icon)
	update_initiative_order(initiative)


func _on_CardMini_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("mini_clicked", self)

func update_initiative_order(new_order):
	initiative.text = String(new_order)
