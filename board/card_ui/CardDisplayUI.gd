extends CanvasLayer

## Buffsactiv  y defense hacer modulate en alpha para no desacomodar la cuadricula
onready var ap_ui = $HBox/VBox/AP
onready var def_ui = $HBox/VBox/Def
onready var hp_ui = $HBox/VBox/HP

onready var buff_box_ui = $HBox/BuffBox

var owner_card = null

const show = Color(1.0, 1.0, 1.0, 1.0)
const hidden = Color(1.0, 1.0, 1.0, 0.0)

const icon_factory = preload('res://board/card_ui/Icon.tscn')

func _ready():
	#esconder defensa y bufos activos si no estan activos
	def_ui.modulate = hidden
	
func update_stats():
	if owner_card == null:
		return
			
	var ap = owner_card.actions_remaining
	var def = owner_card.card_info['defense']
	var hp = owner_card.card_info['current_hp']
	
	ap_ui.get_node("Counter").text = String(ap)
	hp_ui.get_node("Counter").text = String(hp)
	
	if def > 0:
		def_ui.get_node("Counter").text = String(def)
		def_ui.modulate = show
	else:
		def_ui.modulate = hidden
	
func update_mods():
	if owner_card == null:
		return
	var mods = owner_card.modifiers
	
	var ui_buffs = []

	for child in buff_box_ui.get_children():
		ui_buffs.append(child.name)
	
	##desactivar en caso de estar vacio
	if mods.empty() and ui_buffs.size() > 0:
		for icon in buff_box_ui.get_children():
			icon.queue_free()
	else:
		process_mods(mods, ui_buffs)
		

## actualiza buffs activos de la carta a la UI
func process_mods(mods, active_buffs_ui):
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
		
	var new_buffs = get_new_buffs(current_buffs_keys, active_buffs_ui)
	## agrega buffs nuevos
	for buff in new_buffs:
		var icon_buff = icon_factory.instance()
		buff_box_ui.add_child(icon_buff)
		var initial_counter = mods['buff']['turn_counter']
		icon_buff.load_buff(buff, initial_counter)
	
	##Elimina buffs eliminados por accion del oponente
	var deleted_buffs = get_removed_buffs(current_buffs_keys, active_buffs_ui)
	remove_buffs(deleted_buffs)
	

##active_buff_ui son buff en BuffBox
##current_buffs son buffos de carta
##esta funcion revisa si hay diferencias entre buffos PARA AGREGARLOS
func get_new_buffs(current_buffs, active_buff_ui):
	var new_buffs = []
	
	active_buff_ui.sort()
	current_buffs.sort()
	
	if current_buffs == active_buff_ui:
		return new_buffs
	# buscamos que buff no se encuentran actualmente en la UI
	for buff in current_buffs:
		if not(buff in active_buff_ui):
			new_buffs.append(buff)
			
	return new_buffs
	
##active_buff_ui son buff en BuffBox
##current_buffs son buffos de carta
##leer lista y remover buff por nombre
func get_removed_buffs(current_buffs, active_buff_ui):
	var deleted_buffs = []
	
	active_buff_ui.sort()
	current_buffs.sort()
	
	if current_buffs == active_buff_ui:
		return deleted_buffs
	# buscamos que buff no se encuentran actualmente en la carta
	for buff in active_buff_ui:
		if not(buff in current_buffs):
			deleted_buffs.append(buff)
			
	return deleted_buffs


func remove_buffs(buffs):
	for buff in buffs:
		buff_box_ui.get_node(buff).queue_free()
	
func set_owner_card(card):
	owner_card = card
