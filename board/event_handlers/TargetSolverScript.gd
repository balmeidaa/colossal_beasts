extends Spatial

var input_active = false
var action_saved = null

var selected_target = null
###TAL VEZ MOVER ESTO A GAME hANDLER
func _ready():
	GameHandler.target_solver = self
	
#orden de eventos
#hace click en carta y se abre menu
#se hace click en accion
#se activa y se espera click de objetivo de lo contrario se desactiva	
#verificar objetivo sea del tipo correcto si es asi encolar
#de lo contrario resetear

func _process(_delta):
	if input_active == false:
		return
	
	if action_saved['objective_type'] == 'self':
		GameHandler.action_queue.add_ui_action_Q(action_saved)
		reset_state()
		return
	
	if selected_target:
		var ok_target = verify_identity(action_saved['objective_type'], selected_target)
		print(ok_target)
		if  ok_target:
			action_saved['target'] = selected_target
			## Solo si fue exitoso la adicion de accion a la cola se resta puntos de accion
			if GameHandler.turn_system.add_action(action_saved):
				action_saved["card_played"].decrease_actions_remaining()
			
		reset_state()

#func _input(event):
#	if input_active == false:
#		return
	#TODO
	# tal vez resetear el target solver si no obtiene click en ningun objeto valido
	# cancelar si usuario hace clic y no hay objetivo seleccionado
	#aqui no cancelar la accion, ya que no detecta si objetivo fue seleccionado (este evento pasa primero)
	
#	if event is InputEventMouseButton and event.pressed:
#		if event.button_index == BUTTON_LEFT:
#			print(selected_target)
#			#input_active = false
	

	#target solver no tendria q procesar input para evitar bogs

##resolver orden de eventos!!!
	#revisar origen de carta y obtener el jugador
	#obtener objetivo, si es asi mismo enviar a cola de acciones
	#si es enemigo o nueva locacion guardarla
	#enviar a cola
	
	
func establish_action(action):
	action_saved = action
	input_active = true
	



func verify_identity(objective_type, target):
	match(objective_type):
		'ally':
			return target.is_in_group('player_cards')
		'enemy':
			return target.is_in_group('opponent_cards')
		_: #falta implementar objetivo de area, y objetivo libre
			print('Something wrong')
	#
	return false
	
func reset_state()	:
	action_saved = null
	input_active = false
	selected_target = null
