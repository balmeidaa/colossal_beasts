extends CanvasLayer

## Buffsactiv  y defense hacer modulate en alpha para no desacomodar la cuadricula
onready var ap_ui = $HBox/VBox/AP
onready var def_ui = $HBox/VBox/Def
onready var hp_ui = $HBox/VBox/HP

onready var buff_box_ui = $HBox/BuffBox

var owner_card = null
var ui_buffs = []

const show = Color(1.0, 1.0, 1.0, 1.0)
const hidden = Color(1.0, 1.0, 1.0, 0.0)

const icon_factory = preload('res://board/card_ui/Icon.tscn')

func _ready():
	#esconder defensa y bufos activos si no estan activos
	def_ui.modulate = hidden
	
func update_all():
	if owner_card == null:
		return
	var ap = owner_card.actions_remaining
	var def = owner_card.card_info['defense']
	var hp = owner_card.card_info['current_hp']
	var mods = owner_card.modifiers
	
	
	
	## buff despues
	ap_ui.get_node("Counter").text = String(ap)
	hp_ui.get_node("Counter").text = String(hp)

	if def > 0:
		def_ui.get_node("Counter").text = String(def)
		def_ui.modulate = show
	else:
		def_ui.modulate = hidden
	
	##desactivar en caso de estar vacio
	if mods.empty() and ui_buffs.size() > 0:
		for icon in buff_box_ui.get_children():
			icon.queue_free()
	else:
		process_mods(mods)
		
#"buff_ex":{ #ejemplo de buff
#	"script_name":"increase_defense",
#	"trigger_event":"PRECOMBAT",
#	"turn_counter": 3,
#	"type":"BUFF" # buff positivo/ debuff negativo
	#"icon"
#
#}	
##solo agregar o cambiar el texto de buffs
##eliminar primero buffs de la UI y despues del dict en la clase card
func process_mods(mods):
	var to_be_removed = []
	var current_buffs_keys = mods.keys()
	##remover buff ya expirados
	for buff in mods:
		var current_count = mods[buff]['turn_counter']
		if  current_count == 0:
			to_be_removed.append(buff)
		else: ## de lo contrario actualizar el tiempo restante
			buff_box_ui.get_node(buff).set_counter(current_count)
			
	for buff in to_be_removed:
		mods.erase(buff)
		buff_box_ui.get_node(buff).queue_free()
		
	var new_buffs = get_new_buffs(current_buffs_keys)

	for buff in new_buffs:
		var icon_buff = icon_factory.instance()
		buff_box_ui.add_child(icon_buff)
		var initial_counter = mods['buff']['turn_counter']
		icon_buff.load_buff(buff, initial_counter)
	

##ui_buffs son buff en BuffBox
##current_buffs son buffos de carta
##esta funcion revisa si hay diferencias entre buffos PARA AGREGARLOS
func get_new_buffs(current_buffs):
	var new_buffs = []
	
	ui_buffs.sort()
	current_buffs.sort()
	
	if current_buffs == ui_buffs:
		return new_buffs
	
	for buff in current_buffs:
		if not(buff in ui_buffs):
			new_buffs.append(buff)
			
	return new_buffs

##leer lista y remover buff por nombre
func remove_buffs(buffs):
	var buff_list = []
	if not buffs is Array:
		buff_list = [buffs]
	for buff in buff_list:
		buff_box_ui.get_node(buff).queue_free()
	
func set_owner_card(card):
	owner_card = card
