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
	pass
	
func _input(event):
	if input_active == false:
		return
	#target solver no tendria q procesar input para evitar bogs

##resolver orden de eventos!!!
func acquire_target(action):
	action_saved = action
	input_active = true
	#revisar origen de carta y obtener el jugador
	#obtener objetivo, si es asi mismo enviar a cola de acciones
	#si es enemigo o nueva locacion guardarla
	#enviar a cola
	match(action['objective_type']):
		'self':
			GameHandler.action_queue.add_ui_action_Q(action)
			reset_state()
		'ally':
			pass
		'enemy':
			pass
		_:
			pass
	
	action['action_by'] = establish_identity(action)


func establish_identity(objetive_type): 
	#if card_entity.is_in_group('player_cards'):
	return
	
func reset_state()	:
	action_saved = null
	input_active = false
