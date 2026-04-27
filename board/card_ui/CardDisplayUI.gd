extends CanvasLayer

## Buffsactiv  y defense hacer modulate en alpha para no desacomodar la cuadricula
onready var ap_ui = $Grid/AP
onready var buff_ui = $Grid/BuffsActive
onready var def_ui = $Grid/Defense
onready var hp_ui = $Grid/HP

var owner_card = null

const show = Color(1.0, 1.0, 1.0, 1.0)
const hidden = Color(1.0, 1.0, 1.0, 0.0)

#func _ready():
#	#esconder defensa y bufos activos si no estan activos
#	buff_ui.modulate = hidden
#	def_ui.modulate = hidden
	
func update_all():
	if owner_card == null:
		return
	var ap = owner_card.actions_remaining
	var def = owner_card.card_info['defense']
	var hp = owner_card.card_info['current_hp']
	## buff despues
	ap_ui.get_node("Counter").text = String(ap)
	hp_ui.get_node("Counter").text = String(hp)
	def_ui.get_node("Counter").text = String(def)
	


func set_owner_card(card):
	owner_card = card
