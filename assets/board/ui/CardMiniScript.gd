extends TextureRect

signal mini_clicked

onready var action_mini = $ActionMini
onready var initiative = $Initiative

func load_mini(card, action, initiative):
	var img_card = GameData.card_img_path % card
	var action_icon = GameData.action_icon_path % action
	texture = load(card)
	initiative.text = String(initiative)

func _on_CardMini_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("mini_clicked", self)

