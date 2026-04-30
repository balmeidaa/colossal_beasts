extends Node


var buff_helper = load('res://board/action_scripts/BaseActionScript.gd').new()

const BUFF = 'buff'
##variables de control de turno
var state = GameData.States.IDLE
var active_turn = ''
var turn_finished = false
#acciones
var action_q = []
##donde evaluar que el jugador ya hizo todas sus acciones posibles?
##al momento de ejecutar accion como saber esperar y ejecutar la siguiente?

func _ready():
	GameHandler.connect("game_ready", self, 'set_state')
	GameHandler.connect("next_turn", self, 'finish_this_turn') #necesita boton de terminar turno para aplicar
	GameHandler.turn_system = self
	active_turn = 'player'


## un ciclo de la maquina es un turno completo x jugador, despues se cambia al turno del oponente	
func _process(_delta):

	match(state):
		GameData.States.PRECOMBAT:
			#obtener y aplicar efectos que apliquen antes de combate
			set_state(GameData.States.TURN)
		GameData.States.TURN: ## solo este estado aguarda hasta q el jugador termine el turno
			#procesar acciones pendientes
			process_action()
			if turn_finished:
				try_wrap_turn()
				
		GameData.States.POSTCOMBAT:
			#obtener y aplicar efectos que apliquen despues de combate
			pass
			change_turn()
			set_state(GameData.States.PRECOMBAT)
		GameData.States.IDLE:
			pass
		
func process_action():
	if action_q.empty():
		return
		
	var action_dat = action_q.pop_front()
	## Aplicar directamente buffs y salir
	if action_dat['action_type'] ==  BUFF:
		if action_dat['objective_type'] == 'self':
			buff_helper.set_buff(action_dat['card_played'], action_dat['script_name'])
		else:
			buff_helper.set_buff(action_dat['target'], action_dat['script_name'])
		return
			
	var file_name = GameData.scripts_path % action_dat['script_name']
	var action_func = load(file_name).new()
	action_func.execute(action_dat)
	
func change_turn():
	if active_turn == 'player':
		active_turn = 'opponent'
		get_tree().call_group("opponent_cards", "reset_actions_remaining")
	else:
		active_turn = 'player'
		get_tree().call_group("player_cards", "reset_actions_remaining")
	turn_finished = false


func try_wrap_turn():
	if action_q.empty(): ## tal vez esperar que termine alguna animacion pendiente antes de cambiar turno
		set_state(GameData.States.POSTCOMBAT)
	
# no agregar mas accion si el jugador ya termino su turno
# no abrir el menu de accion
func add_action(action):
	if turn_finished:
		return false
	action_q.append(action)
	return true

#cambio de nombre para evitar confunciones
func finish_this_turn():
	turn_finished = true

func set_state(new_state):
	state = new_state
	

